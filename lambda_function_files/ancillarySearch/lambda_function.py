import requests
import json
from requests.auth import HTTPBasicAuth
from urllib.parse import urlencode

def lambda_handler(event, context):
    try:
        
        booking_key = event.get("bookingKey")
        print(booking_key)
        #booking_key = "JuoyOVtsX8Mo¥pOTIlzgeI495bjtSxxIdnsgR6j3j60BQ6yqk9jƒG77oUgcQyiIqxruFlkP6zvvnN1MINAyg0ejZuOGYSTaPxQ94TKfMVƒrCIhIqLQCeV1zglHMwFe2nuKTz7O55eFI276zFyYeSm1EOSd4ƒQvTxfItYPneoE5wPw690nBeuGuF2cBbYkaY5MFCxndYtg6dfmADMGJ2YC7UlGlzƒU4KAQQM8yapFMRrIRwehOjdLlDIXZkwdfuKfLpawGL412LI6dpjGzFS3tU3fYiqHIBbTXroj2ErGpAcX2poDj7IwK2u02ihPrcRirXJWrkVorMxpaAMo1dJaUGJRGƒcm4Rk4DsƒvVCKuKjzqgkD7KFfFGuk510m3e1lhNsUPT1crRWfPl5wfxUSWoAG2OLHPueEQTUHg1xcWbuREFKGZ010qfLBPf7eCltba0RGXN1z1Td3B¥403aqpoKDJƒCdTOHaUyPPOJgmQxJRyN7kvToiASxYqzbPVDDMEHLO2PW11bZSSaOBghKyJCIlfWd3Qvƒ6c4gC9H7PvpKjc="
        
        # Ensure booking key is provided
        if not booking_key:
            raise ValueError("Booking key is missing in the event data")
        #booking_key = booking_key.replace('¥', '').replace('ƒ', '')
        
        # Construct URL to fetch ancillary options using the booking key
        ancillary_options_url = f'https://flairair-api.intelisystraining.ca/RESTv1/ancillaryOptions?bookingKey={booking_key}'
        
        # Make the request to get ancillary options data
        response = requests.get(ancillary_options_url)
        response.raise_for_status()  # Raise an exception for 4xx or 5xx status codes
        
        # Parse the JSON response
        ancillary_data = response.json()
        
        # List to store ancillary details
        ancillary_details_list = []
        
        # Loop through all ancillary options
        for ancillary_option in ancillary_data:
            # Check if the ancillary option has a valid structure
            ancillary_item = ancillary_option.get('ancillaryItem', {})
            ancillary_name = ancillary_item.get('name', 'Unknown')
            
            # Extract the purchase key
            purchase_key = ancillary_option.get('purchaseKey', 'N/A')
            
            # Extract price details
            charge_info = ancillary_option.get('ancillaryCharges', [{}])[0].get('currencyAmounts', [{}])[0]
            ancillary_price_details = {
                "baseAmount": charge_info.get('baseAmount', 0),
                "discountAmount": charge_info.get('discountAmount', 0),
                "totalTaxAmount": charge_info.get('taxAmount', 0),
                "taxRateAmounts": charge_info.get('taxRateAmounts', [{}]),
                "totalAmount": charge_info.get('totalAmount', 0)
                
            }
            
            # Add the ancillary option details to the list
            ancillary_details_list.append({
                "ancillaryName": ancillary_name,
                "purchaseKey": purchase_key,
                "priceDetails": ancillary_price_details
            })
        
        # Return the proper JSON response
        return {
            'statusCode': 200,
            'body': ancillary_details_list  # Directly return the list
        }
    
    except requests.HTTPError as e:
        return {
            'statusCode': e.response.status_code,
            'body': {'error': f'HTTP error occurred: {e.response.text}'}
        }
    
    except ValueError as e:
        return {
            'statusCode': 400,
            'body': {'error': f'Value error occurred: {str(e)}'}
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': {'error': f'An error occurred: {str(e)}'}
        }
