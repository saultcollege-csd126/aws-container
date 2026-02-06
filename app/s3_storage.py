"""AWS S3 helper functions for image storage"""
import boto3
from botocore.exceptions import ClientError
import uuid
from datetime import datetime


class S3Storage:
    def __init__(self, bucket_name, region):
        self.bucket_name = bucket_name
        self.region = region
        self.s3_client = boto3.client('s3', region_name=region)
    
    def upload_image(self, file_obj, filename, content_type):
        """Upload an image to S3 and return the key"""
        try:
            # Generate unique filename
            ext = filename.rsplit('.', 1)[1].lower() if '.' in filename else ''
            unique_filename = f"{uuid.uuid4()}.{ext}"
            
            # Upload file
            self.s3_client.put_object(
                Bucket=self.bucket_name,
                Key=unique_filename,
                Body=file_obj,
                ContentType=content_type
            )
            
            return {'success': True, 'key': unique_filename}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def delete_image(self, key):
        """Delete an image from S3"""
        try:
            self.s3_client.delete_object(
                Bucket=self.bucket_name,
                Key=key
            )
            return {'success': True}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def get_image_url(self, key):
        """Generate a presigned URL for viewing an image"""
        try:
            url = self.s3_client.generate_presigned_url(
                'get_object',
                Params={'Bucket': self.bucket_name, 'Key': key},
                ExpiresIn=3600  # URL valid for 1 hour
            )
            return {'success': True, 'url': url}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
