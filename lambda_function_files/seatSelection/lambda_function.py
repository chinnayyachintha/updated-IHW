import json
import requests

def lambda_handler(event, context):
    # Extract booking key from the event
    booking_key = event.get('bookingKey')
    
    # Construct the API URL
    api_url = f"https://flairair-api.intelisystraining.ca/RESTv1/seatSelectionOptions?bookingKey={booking_key}"
    
    try:
        # Make the GET request to the API
        response = requests.get(api_url)
        response.raise_for_status()  # Raise an error for bad responses

        # Parse the response JSON
        seat_selection_data = response.json()

        # Process the data to build the desired response format
        formatted_response = []
        
        for option in seat_selection_data:
            for seat_option in option.get('seatOptions', []):
                seat_map_cell = seat_option.get('seatMapCell', {})
                seat_charges = seat_option.get('seatCharges', [])
                
                # Collect currency amounts
                currency_amounts = []
                for charge in seat_charges:
                    for currency in charge.get('currencyAmounts', []):
                        currency_amounts.append({
                            "currency": currency['currency']['code'],
                            "baseAmount": currency['baseAmount'],
                            "totalTaxAmount": currency['taxAmount'],
                            "taxRateAmounts": currency['taxRateAmounts'],
                            "totalAmount": currency['totalAmount']
                            
                        })
                
                # Append formatted seat option to the response list
                formatted_response.append({
                    "selectionKey": seat_option.get('selectionKey'),
                    "key": seat_map_cell.get('key'),
                    "rowIdentifier": seat_map_cell.get('rowIdentifier'),
                    "seatIdentifier": seat_map_cell.get('seatIdentifier'),
                    "seatQualifiers": seat_map_cell.get('seatQualifiers', {}),
                    "currencyAmounts": currency_amounts
                })

        # Build the final response structure
        return {
            "statusCode": 200,
            "body": formatted_response
        }
        
    except requests.exceptions.RequestException as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }

