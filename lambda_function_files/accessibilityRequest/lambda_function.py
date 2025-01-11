import json
import requests
import boto3
from botocore.exceptions import ClientError

def get_ssm_parameter(parameter_name):
    """Retrieve the parameter value from SSM Parameter Store."""
    ssm = boto3.client('ssm')
    try:
        response = ssm.get_parameter(Name=parameter_name, WithDecryption=True)
        return response['Parameter']['Value']
    except ClientError as e:
        print(f"Error retrieving parameter {parameter_name}: {str(e)}")
        return None

def lambda_handler(event, context):
    # Retrieve credentials from SSM Parameter Store
    username = get_ssm_parameter('/flairgate/apiuser')
    password = get_ssm_parameter('/flairgate/apipassword')

    if not username or not password:
        return {
            'statusCode': 500,
            'body': json.dumps('Failed to retrieve credentials.')
        }

    # URL to make the GET request
    url = 'https://flairair-api.intelisystraining.ca/RESTv1/serviceRequests?serviceRequestTypeCode=PRM'
    
    # Making the GET request with basic authentication
    try:
        response = requests.get(url, auth=(username, password))
        
        # Check if the request was successful
        if response.status_code == 200:
            # Print the response data
            print("Response JSON:", response.json())
            return {
                'statusCode': 200,
                'body': response.json()
            }
        else:
            print(f"Failed to retrieve data: {response.status_code} {response.text}")
            return {
                'statusCode': response.status_code,
                'body': response.text
            }
    except Exception as e:
        print(f"An error occurred: {str(e)}")
        return {
            'statusCode': 500,
            'body': str(e)
        }