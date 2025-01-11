import requests
import json
import boto3
from requests.auth import HTTPBasicAuth

def get_parameter(param_name):
    ssm = boto3.client('ssm')
    response = ssm.get_parameter(Name=param_name, WithDecryption=True)
    return response['Parameter']['Value']

def lambda_handler(event, context):
    # Log the entire event for debugging
    print("Event received:", json.dumps(event))
    
    # Ensure 'queryStringParameters' exists and extract reservationKey
    if 'queryStringParameters' not in event or not event['queryStringParameters']:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Missing queryStringParameters in request'})
        }

    # Extract reservationKey from query parameters
    reservation_key = event['queryStringParameters'].get('reservationKey')
    if not reservation_key:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Missing reservationKey in query parameters'})
        }
    print("Reservation Key:", reservation_key)
    
    # Validate the reservation key by making a GET request
    validation_url = f"https://flairair-api.intelisystraining.ca/RESTv1/reservations/{reservation_key}"
    username = get_parameter('/flairgate/apiuser')
    password = get_parameter('/flairgate/apipassword')

    validation_response = requests.get(
        validation_url,
        auth=HTTPBasicAuth(username, password),
        headers={"Content-Type": "application/json"}
    )
    
    # Log the validation response for debugging
    print("Validation Response Status Code:", validation_response.status_code)
    print("Validation Response Text:", validation_response.text)
    
    if validation_response.status_code != 200:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Invalid reservationKey'})
        }

    # Retrieve and parse request body
    request_body = event.get('body')
    if request_body:
        try:
            event_body = json.loads(request_body) if isinstance(request_body, str) else request_body
        except json.JSONDecodeError:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'Invalid JSON in request body'})
            }
    else:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Missing request body'})
        }

    # API endpoint URL with reservationKey
    url = f"https://flairair-api.intelisystraining.ca/RESTv1/reservations/{reservation_key}/paymentTransactions"
    
    # Make the POST request to the API
    response = requests.post(
        url,
        auth=HTTPBasicAuth(username, password),
        headers={"Content-Type": "application/json"},
        json=event_body
    )
    
    # Log the full response details for debugging
    print("API Response Status Code:", response.status_code)
    print("API Response Text:", response.text)
    
    # Return the response directly as JSON
    try:
        api_response = response.json()  # Attempt to parse JSON response
        return {
            'statusCode': response.status_code,
            'body': api_response  # Return the parsed JSON response
        }
    except json.JSONDecodeError:
        # If the response is not JSON, return the raw text
        return {
            'statusCode': response.status_code,
            'body': response.text
        }
