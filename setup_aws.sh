#!/bin/bash
# Helper script to set up AWS infrastructure for the Flask Image Gallery app
# This script creates the necessary AWS resources using AWS CLI

set -e  # Exit on error

echo "======================================"
echo "Flask Image Gallery - AWS Setup Script"
echo "======================================"
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed. Please install it first."
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "Error: AWS credentials are not configured properly."
    echo "Please configure your AWS credentials first."
    exit 1
fi

echo "✓ AWS CLI is configured"
echo ""

# Get AWS region (default to us-east-1)
AWS_REGION=${AWS_REGION:-us-east-1}
echo "Using AWS Region: $AWS_REGION"
echo ""

# Generate unique resource names
TIMESTAMP=$(date +%s)
PROJECT_NAME="flask-image-gallery"
BUCKET_NAME="${PROJECT_NAME}-${TIMESTAMP}"
TABLE_NAME="image-metadata"

echo "======================================"
echo "Step 1: Creating S3 Bucket"
echo "======================================"
echo "Bucket Name: $BUCKET_NAME"

if aws s3 mb "s3://${BUCKET_NAME}" --region "${AWS_REGION}"; then
    echo "✓ S3 bucket created successfully"
else
    echo "✗ Failed to create S3 bucket"
    exit 1
fi
echo ""

echo "======================================"
echo "Step 2: Creating DynamoDB Table"
echo "======================================"
echo "Table Name: $TABLE_NAME"

if aws dynamodb create-table \
    --table-name "${TABLE_NAME}" \
    --attribute-definitions AttributeName=image_id,AttributeType=S \
    --key-schema AttributeName=image_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region "${AWS_REGION}" > /dev/null; then
    echo "✓ DynamoDB table created successfully"
else
    echo "✗ Failed to create DynamoDB table (it may already exist)"
fi
echo ""

echo "======================================"
echo "Step 3: Creating Cognito User Pool"
echo "======================================"

# Create Cognito User Pool
USER_POOL_NAME="${PROJECT_NAME}-users"
echo "Creating User Pool: $USER_POOL_NAME"

USER_POOL_ID=$(aws cognito-idp create-user-pool \
    --pool-name "${USER_POOL_NAME}" \
    --policies "PasswordPolicy={MinimumLength=8,RequireUppercase=true,RequireLowercase=true,RequireNumbers=true,RequireSymbols=false}" \
    --auto-verified-attributes email \
    --region "${AWS_REGION}" \
    --query 'UserPool.Id' \
    --output text)

if [ -z "$USER_POOL_ID" ]; then
    echo "✗ Failed to create Cognito User Pool"
    exit 1
fi
echo "✓ User Pool created: $USER_POOL_ID"
echo ""

# Create Cognito User Pool Client
echo "Creating User Pool Client..."
CLIENT_OUTPUT=$(aws cognito-idp create-user-pool-client \
    --user-pool-id "${USER_POOL_ID}" \
    --client-name "${PROJECT_NAME}-client" \
    --generate-secret \
    --explicit-auth-flows USER_PASSWORD_AUTH \
    --region "${AWS_REGION}")

CLIENT_ID=$(echo "$CLIENT_OUTPUT" | grep -oP '"ClientId":\s*"\K[^"]+')
CLIENT_SECRET=$(echo "$CLIENT_OUTPUT" | grep -oP '"ClientSecret":\s*"\K[^"]+')

if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ]; then
    echo "✗ Failed to create Cognito User Pool Client"
    exit 1
fi
echo "✓ User Pool Client created"
echo ""

echo "======================================"
echo "Setup Complete!"
echo "======================================"
echo ""
echo "AWS Resources Created:"
echo "  • S3 Bucket: $BUCKET_NAME"
echo "  • DynamoDB Table: $TABLE_NAME"
echo "  • Cognito User Pool ID: $USER_POOL_ID"
echo "  • Cognito Client ID: $CLIENT_ID"
echo ""
echo "Next Steps:"
echo "1. Create a .env file with the following content:"
echo ""
cat << ENVFILE
SECRET_KEY=$(openssl rand -hex 32)
AWS_REGION=${AWS_REGION}
COGNITO_USER_POOL_ID=${USER_POOL_ID}
COGNITO_CLIENT_ID=${CLIENT_ID}
COGNITO_CLIENT_SECRET=${CLIENT_SECRET}
S3_BUCKET_NAME=${BUCKET_NAME}
DYNAMODB_TABLE_NAME=${TABLE_NAME}
ENVFILE
echo ""
echo "2. Run the Flask application:"
echo "   python -m app.app"
echo ""
echo "======================================"
