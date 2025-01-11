import boto3
import jwt
import json
import urllib.request
ssm = boto3.client('ssm')
def lambda_handler(event, context):
    # Retrieve the JWT token from the event
    token = event['authorizationToken']
    # Your JWT secret key
    secret_key = ssm.get_parameter(Name='/jwt/secret-key/dev', WithDecryption=True)['Parameter']['Value']
    #secret_key = 'e02dc24260a20e5f3864debf5d768a75e5bb94a3fe43f3490df1776fb8cf9be2'
    try:
        # Decode and verify the JWT token
        decoded_token = jwt.decode(token, secret_key, algorithms=['HS256'])
        print(decoded_token)
        # Extract any necessary information from the decoded token
        # Return an IAM policy allowing access
        return generate_policy('user', 'Allow', event['methodArn'])
    except jwt.ExpiredSignatureError:
        # Token has expired
        return generate_policy('user', 'Deny', event['methodArn'])
    except jwt.InvalidTokenError:
        # Invalid token
        return generate_policy('user', 'Deny', event['methodArn'])
def generate_policy(principal_id, effect, resource):
    # Generate an IAM policy
    auth_response = {}
    auth_response['principalId'] = principal_id
    if effect and resource:
        policy_document = {
            'Version': '2012-10-17',
            'Statement': [{
                'Action': 'execute-api:Invoke',
                'Effect': effect,
                'Resource': resource
            }]
        }
        auth_response['policyDocument'] = policy_document
    return auth_response