import requests
import json
import boto3
from requests.auth import HTTPBasicAuth
import logging

# Define constants
PARAMETER_USERNAME = '/flairgate/apiuser'
PARAMETER_PASSWORD = '/flairgate/apipassword'
API_BASE_URL = 'https://flairair-api.intelisystraining.ca/RESTv1'
ANCILLARY_OPTIONS_INDEX = 4

# Initialize the logger
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def get_parameter(param_name):
    """Retrieve a parameter from AWS SSM Parameter Store."""
    ssm = boto3.client('ssm')
    response = ssm.get_parameter(Name=param_name, WithDecryption=True)
    return response['Parameter']['Value']

def send_get_request(url, auth):
    """Send a GET request to the API."""
    try:
        response = requests.get(url, auth=auth)
        response.raise_for_status()
        return response.json()
    except requests.HTTPError as e:
        logger.error(f'HTTP error occurred: {e.response.text}')
        raise
    except Exception as e:
        logger.error(f'An error occurred: {str(e)}')
        raise

def lambda_handler(event, context):
    """Handle the AWS Lambda event."""
    # Retrieve username and password from Parameter Store
    try:
        username = get_parameter(PARAMETER_USERNAME)
        password = get_parameter(PARAMETER_PASSWORD)
    except Exception as e:
        logger.error(f'Error retrieving credentials: {str(e)}')
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'Error retrieving credentials'})
        }

    # Ensure event is a dictionary
    if not isinstance(event, dict):
        logger.error('Event must be a dictionary')
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Event must be a dictionary'})
        }

    # Retrieve event parameters safely
    passenger_counts = event.get('passengerCounts')
    currency = event.get('currency')
    departure = event.get('departure')
    city_pair = event.get('cityPair')

    # Validate that all parameters are provided
    if not all([passenger_counts, currency, departure, city_pair]):
        logger.error('Missing required query parameters')
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Missing required query parameters'})
        }

    # Construct the URL
    base_url = f'{API_BASE_URL}/travelOptions'
    url = f'{base_url}?passengerCounts={passenger_counts}&currency={currency}&departure={departure}&cityPair={city_pair}'

    try:
        # Send a GET request to the API
        response = send_get_request(url, HTTPBasicAuth(username, password))
        passenger_data = response

        # Ensure passenger_data is a list before accessing elements
        if isinstance(passenger_data, list) and len(passenger_data) > 0:
            fare_options = passenger_data[0].get('fareOptions', [])
            if len(fare_options) > 0:
                booking_key = fare_options[0].get('bookingKey', None)
            else:
                logger.error('No fareOptions found in response')
                return {
                    'statusCode': 500,
                    'body': json.dumps({'error': 'No fareOptions found in response'})
                }
        else:
            logger.error('Unexpected passenger data format')
            return {
                'statusCode': 500,
                'body': json.dumps({'error': 'Unexpected passenger data format'})
            }

        # Check if the booking key exists
        if not booking_key:
            logger.error('Booking key not found in response')
            return {
                'statusCode': 500,
                'body': json.dumps({'error': 'Booking key not found in response'})
            }

        # Construct the ancillary options URL
        api_url = f'{API_BASE_URL}/ancillaryOptions?bookingKey={booking_key}'

        # Send a GET request for ancillary options
        response = send_get_request(api_url, HTTPBasicAuth(username, password))
        ancillary_options_data = response

        # Ensure ancillary_options_data is a list
        if isinstance(ancillary_options_data, list) and len(ancillary_options_data) > ANCILLARY_OPTIONS_INDEX:
            ancillary_items = ancillary_options_data[ANCILLARY_OPTIONS_INDEX].get('ancillaryItem', [])
        else:
            logger.error('Unexpected ancillary options data format')
            return {
                'statusCode': 500,
                'body': json.dumps({'error': 'Unexpected ancillary options data format'})
            }

        # Initialize the list to hold all matching ancillary items
        matching_items = []

        # Loop through the JSON list
        for item in ancillary_options_data:
            ancillary_item = item.get('ancillaryItem', {})
            ancillary_category = ancillary_item.get('ancillaryCategory', {})

            # Check if the index within ancillaryCategory is 1
            if ancillary_category.get('index') == 1:
                matching_items.append(ancillary_item)

        # If we found any matching ancillary items, print and return them
        if matching_items:
            # Print all matching ancillaryItems
            logger.info(json.dumps(matching_items))

            # Return all matching ancillaryItems
            return {
                'statusCode': 200,
                #'body': json.dumps(matching_items)
                'body': matching_items
            }

    except Exception as e:
        # Return a generic error message
        logger.error(f'An error occurred: {str(e)}')
        return {
            'statusCode': 500,
            'body': json.dumps({'error': 'An error occurred'})
        }
