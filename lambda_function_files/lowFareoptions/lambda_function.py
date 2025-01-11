import json
import requests

def lambda_handler(event, context):
    # Extract parameters from the event object
    departure_date = event.get('departureDate', "2024-10-05")
    city_pair = event.get('cityPair', "YYZ-YVR")
    days_after_departure = event.get('daysAfterDeparture', 25)
    passenger_count = event.get('passengerCount', "ADT:1")
    currency = event.get('currency', "CAD")
    
    # API URL
    url = f"https://flairair-api.intelisystraining.ca/RESTv1/travelOptions?daysAfterDeparture={days_after_departure}&passengerCounts={passenger_count}&currency={currency}&departure={departure_date}&cityPair={city_pair}"
    
    try:
        # Send GET request to the API
        response = requests.get(url)
        response.raise_for_status()
        
        # Parse the response JSON
        data = response.json()
        
        # Dictionary to track the lowest fare per departure date
        fare_by_date = {}
        
        for option in data:
            departure_date = option.get('departureDate')
            fare_info = option.get('fareOptions', [{}])[0]  # Get first fare option if exists
            
            # Extract fare charges
            fare_charges = fare_info.get('fareCharges', [{}])[0]
            fare_amount = fare_charges.get('currencyAmounts', [{}])[0].get('totalAmount')
            
            if departure_date and fare_amount is not None:
                # Update the dictionary with the minimum fare for each departure date
                if departure_date not in fare_by_date or fare_amount < fare_by_date[departure_date]:
                    fare_by_date[departure_date] = fare_amount
        
        # Convert the fare_by_date dictionary into a list of dictionaries
        travel_details = [{"departure_date": date, "cheapest_fare": fare} for date, fare in fare_by_date.items()]
        
        # Return the response as a list of dictionaries
        return {
            'statusCode': 200,
            'body': travel_details
        }
    
    except requests.exceptions.RequestException as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
