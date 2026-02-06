"""AWS Cognito authentication helper functions"""
import boto3
import hmac
import hashlib
import base64
from botocore.exceptions import ClientError


class CognitoAuth:
    def __init__(self, user_pool_id, client_id, client_secret, region):
        self.user_pool_id = user_pool_id
        self.client_id = client_id
        self.client_secret = client_secret
        self.region = region
        self.client = boto3.client('cognito-idp', region_name=region)
    
    def _get_secret_hash(self, username):
        """Calculate SECRET_HASH for Cognito"""
        message = bytes(username + self.client_id, 'utf-8')
        secret = bytes(self.client_secret, 'utf-8')
        dig = hmac.new(secret, msg=message, digestmod=hashlib.sha256).digest()
        return base64.b64encode(dig).decode()
    
    def sign_up(self, username, password, email):
        """Register a new user"""
        try:
            response = self.client.sign_up(
                ClientId=self.client_id,
                SecretHash=self._get_secret_hash(username),
                Username=username,
                Password=password,
                UserAttributes=[
                    {'Name': 'email', 'Value': email}
                ]
            )
            return {'success': True, 'user_sub': response['UserSub']}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def confirm_sign_up(self, username, confirmation_code):
        """Confirm user registration"""
        try:
            self.client.confirm_sign_up(
                ClientId=self.client_id,
                SecretHash=self._get_secret_hash(username),
                Username=username,
                ConfirmationCode=confirmation_code
            )
            return {'success': True}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def sign_in(self, username, password):
        """Sign in a user"""
        try:
            response = self.client.initiate_auth(
                ClientId=self.client_id,
                AuthFlow='USER_PASSWORD_AUTH',
                AuthParameters={
                    'USERNAME': username,
                    'PASSWORD': password,
                    'SECRET_HASH': self._get_secret_hash(username)
                }
            )
            return {
                'success': True,
                'id_token': response['AuthenticationResult']['IdToken'],
                'access_token': response['AuthenticationResult']['AccessToken'],
                'refresh_token': response['AuthenticationResult']['RefreshToken']
            }
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def verify_token(self, token):
        """Verify an ID token and return user info"""
        try:
            response = self.client.get_user(
                AccessToken=token
            )
            username = response['Username']
            attributes = {attr['Name']: attr['Value'] for attr in response['UserAttributes']}
            return {'success': True, 'username': username, 'attributes': attributes}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
