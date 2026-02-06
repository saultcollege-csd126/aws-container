"""AWS DynamoDB helper functions for image metadata"""
import boto3
from botocore.exceptions import ClientError
from datetime import datetime
from decimal import Decimal


class DynamoDBMetadata:
    def __init__(self, table_name, region):
        self.table_name = table_name
        self.region = region
        self.dynamodb = boto3.resource('dynamodb', region_name=region)
        self.table = self.dynamodb.Table(table_name)
    
    def create_image_metadata(self, image_id, owner, original_filename, s3_key):
        """Create metadata entry for an uploaded image"""
        try:
            timestamp = datetime.utcnow().isoformat()
            item = {
                'image_id': image_id,
                'owner': owner,
                'original_filename': original_filename,
                's3_key': s3_key,
                'created_at': timestamp,
                'status': 'active'
            }
            self.table.put_item(Item=item)
            return {'success': True, 'item': item}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def get_image_metadata(self, image_id):
        """Get metadata for a specific image"""
        try:
            response = self.table.get_item(Key={'image_id': image_id})
            if 'Item' in response:
                return {'success': True, 'item': response['Item']}
            else:
                return {'success': False, 'error': 'Image not found'}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def get_user_images(self, owner):
        """Get all images for a specific user"""
        try:
            response = self.table.scan(
                FilterExpression='#owner = :owner AND #status = :status',
                ExpressionAttributeNames={
                    '#owner': 'owner',
                    '#status': 'status'
                },
                ExpressionAttributeValues={
                    ':owner': owner,
                    ':status': 'active'
                }
            )
            items = response.get('Items', [])
            # Sort by created_at descending
            items.sort(key=lambda x: x.get('created_at', ''), reverse=True)
            return {'success': True, 'items': items}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def get_recent_images(self, limit=10):
        """Get most recently uploaded images from all users"""
        try:
            response = self.table.scan(
                FilterExpression='#status = :status',
                ExpressionAttributeNames={
                    '#status': 'status'
                },
                ExpressionAttributeValues={
                    ':status': 'active'
                }
            )
            items = response.get('Items', [])
            # Sort by created_at descending and limit
            items.sort(key=lambda x: x.get('created_at', ''), reverse=True)
            return {'success': True, 'items': items[:limit]}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
    
    def delete_image_metadata(self, image_id):
        """Delete (soft delete) image metadata"""
        try:
            self.table.update_item(
                Key={'image_id': image_id},
                UpdateExpression='SET #status = :status',
                ExpressionAttributeNames={'#status': 'status'},
                ExpressionAttributeValues={':status': 'deleted'}
            )
            return {'success': True}
        except ClientError as e:
            return {'success': False, 'error': str(e)}
