import json
import requests

def lambda_handler(event, context):
    # Extracting parameters from the event
    days_after_departure = event.get('daysAfterDeparture', 0)
    passenger_count = event.get('passengerCount', 'ADT:1')
    currency = event.get('currency', 'CAD')
    departure_date = event.get('departureDate', '2024-11-10')
    city_pair = event.get('cityPair', 'YYZ-YVR')
    
    # API endpoint with dynamic URL parameters
    url = f"https://flairair-api.intelisystraining.ca/RESTv1/travelOptions?daysAfterDeparture={days_after_departure}&passengerCounts={passenger_count}&currency={currency}&departure={departure_date}&cityPair={city_pair}"
    
    try:
        # Make API request
        response = requests.get(url)
        response.raise_for_status()  # Raise error for bad status codes
        
        # Process the JSON response
        travel_options = response.json()
        
        # List to store formatted flight details
        formatted_travel_details = []

        for option in travel_options:
            # Extracting details
            city_pair = option['cityPair']['identifier']
            departure_date = option['departureDate']
            number_of_stops = option['numberOfStops']
            en_route_hours = option['enRouteHours']
            
            for flight_info in option['flights']:
                flight_number = flight_info['flightNumber']
                aircraft_model = flight_info['aircraftModel']['name'].replace('-', '')  # Remove dashes in aircraft model
                departure_airport = flight_info['departure']['airport']['code']
                arrival_airport = flight_info['arrival']['airport']['code']
                scheduled_departure = flight_info['departure']['localScheduledTime']
                scheduled_arrival = flight_info['arrival']['localScheduledTime']
                
                # Fare details (assuming first fare option)
                fare_option = option['fareOptions'][0]
                booking_key = fare_option['bookingKey']
                fare_class = fare_option['fareClass']['description']
                total_fare = fare_option['fareCharges'][0]['currencyAmounts'][0]['totalAmount']
                currency_code = fare_option['fareCharges'][0]['currencyAmounts'][0]['currency']['code']
                
                # Create a dictionary for each flight detail
                flight_info_dict = {
                    "citypair": city_pair,
                    "booking_key": booking_key,
                    "departure_date": departure_date,
                    "number_of_stops": number_of_stops,
                    "en_route_hours": en_route_hours,
                    "flight_number": flight_number,
                    "aircraft_model": aircraft_model,
                    "departure_airport": departure_airport,
                    "arrival_airport": arrival_airport,
                    "scheduled_departure": scheduled_departure,
                    "scheduled_arrival": scheduled_arrival,
                    "fare_class": fare_class,
                    "total_fare": total_fare,
                    "currency_code": currency_code
                }

                # Append the dictionary to the list
                formatted_travel_details.append(flight_info_dict)
        
        # Return the formatted output as a JSON array of objects
        return {
            'statusCode': 200,
            'body': formatted_travel_details  # Return as a native list of dictionaries
        }
        
    except requests.exceptions.RequestException as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
