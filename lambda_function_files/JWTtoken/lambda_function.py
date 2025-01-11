import boto3
import json
import jwt
from datetime import datetime, timedelta

ssm_client = boto3.client('ssm')

# Static secret key (keep this secret!)
SECRET_KEY = ssm_client.get_parameter(Name='/jwt/secret-key/dev', WithDecryption=True)['Parameter']['Value']

def lambda_handler(event, context):
    try:
        # Your secret key (keep this secret!)
        secret_key = SECRET_KEY
        # Current time
        current_time = datetime.utcnow()

        # Payload (claims) to be included in the token
        payload = {
            'sub': event['sub'],
            'name': event['name'],
            'admin': event['admin'],
            'iat': current_time,
            'exp': current_time + timedelta(hours=720)  # Token expires in 15 mintues
        }

        # Generate the JWT token
        token = jwt.encode(payload, secret_key, algorithm='HS256')
        
        pname = event['name']
        parameter_name = f'/jwt/token/dev/{pname}'
        parameter_value = token
        
        # Store the token in AWS SSM Parameter Store
        response = ssm_client.put_parameter(
            Name=parameter_name,
            Value=parameter_value,
            Type='SecureString',
            Overwrite=True
        )

        # Return response with status code and body
        return { 
            'statusCode': 200,
            'body': { 
                'sub': event['sub'],
                'name': event['name'],
                'admin': event['admin'],
                'token': token
            }
        }

    except KeyError as e:
        return {
            'statusCode': 400,
            'body': {
                'message': f'Invalid input'
            }
        }
    
    except Exception as e:
        return {
            'statusCode': 500,
            'body': {
                'message': 'Internal server error',
                'error': str(e)
            }
        }
