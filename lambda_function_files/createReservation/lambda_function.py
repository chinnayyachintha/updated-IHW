import requests
import json
import boto3
from requests.auth import HTTPBasicAuth

def get_parameter(param_name):
    ssm = boto3.client('ssm')
    response = ssm.get_parameter(Name=param_name, WithDecryption=True)
    return response['Parameter']['Value']

def lambda_handler(event, context):
    parameter_username = '/flairgate/apiuser'
    parameter_password = '/flairgate/apipassword'
    
    # Retrieve username and password from Parameter Store
    username = get_parameter(parameter_username)
    password = get_parameter(parameter_password)

    # API endpoint URL
    url = "https://flairair-api.intelisystraining.ca/RESTv1/reservations"
    
    # Make the POST request to the API
    response = requests.post(url, auth=HTTPBasicAuth(username, password), headers={
        "Content-Type": "application/json"
    }, json=event)  # Directly passing the event data as JSON payload

    # Return the response from the API without modifications
    if response.status_code == 201:
        return {
            'statusCode': 201,
            'body': response.json()  # Return the JSON response directly
        }
    else:
        return {
            'statusCode': response.status_code,
            'body': response.text  # Return the error message from the API
        }
