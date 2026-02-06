# Flask Image Gallery Application

A Flask-based image gallery application that uses AWS Cognito for authentication, S3 for image storage, and DynamoDB for metadata management.

## Features

1. **User Authentication**: Login and registration via AWS Cognito user pool
2. **Image Upload**: Authenticated users can upload images (PNG, JPG, JPEG, GIF, WEBP)
3. **Image Management**: Users can view and delete their uploaded images
4. **Public Gallery**: Home page displays the most recently uploaded images from all users
5. **AWS Integration**: 
   - Cognito for user management
   - S3 for image storage
   - DynamoDB for metadata (owner, created_at, status)

## Prerequisites

Before running the application, you need to set up the following AWS resources:

### 1. AWS Cognito User Pool

Create a Cognito User Pool with the following settings:
- Enable username and email authentication
- Create an app client with the following settings:
  - Enable `USER_PASSWORD_AUTH` flow
  - Generate a client secret
  - Configure callback URLs if needed

### 2. AWS S3 Bucket

Create an S3 bucket for storing images:
```bash
aws s3 mb s3://your-bucket-name --region us-east-1
```

### 3. AWS DynamoDB Table

Create a DynamoDB table with the following structure:
```bash
aws dynamodb create-table \
    --table-name image-metadata \
    --attribute-definitions AttributeName=image_id,AttributeType=S \
    --key-schema AttributeName=image_id,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-1
```

## Installation

1. Clone the repository and navigate to the project directory

2. Create and activate a virtual environment:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Configure environment variables:
```bash
cp .env.example .env
```

Edit the `.env` file with your AWS credentials and resource information:
```
SECRET_KEY=your-secret-key-here
AWS_REGION=us-east-1
COGNITO_USER_POOL_ID=us-east-1_XXXXXXXXX
COGNITO_CLIENT_ID=xxxxxxxxxxxxxxxxxxxxxxxxxx
COGNITO_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
S3_BUCKET_NAME=your-bucket-name
DYNAMODB_TABLE_NAME=image-metadata
```

5. Ensure your AWS credentials are configured:
```bash
# Either set environment variables
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_SESSION_TOKEN=your_session_token  # if applicable

# Or use the .aws/credentials file (already configured in dev container)
```

## Running the Application

### Development Mode

Run the Flask application in development mode:
```bash
python -m app.app
```

Or using Flask CLI:
```bash
export FLASK_APP=app.app
export FLASK_ENV=development
flask run --host=0.0.0.0 --port=5000
```

The application will be available at `http://localhost:5000`

### Production Mode

For production deployment on an EC2 instance, use a WSGI server like Gunicorn:

1. Install Gunicorn:
```bash
pip install gunicorn
```

2. Run with Gunicorn:
```bash
gunicorn -w 4 -b 0.0.0.0:5000 app.app:app
```

## Usage

1. **Register**: Navigate to `/register` to create a new account
2. **Confirm Email**: Check your email for the confirmation code and enter it at `/confirm`
3. **Login**: Navigate to `/login` to sign in
4. **Upload Images**: Once logged in, go to `/upload` to upload images
5. **View Your Gallery**: Navigate to `/gallery` to see and manage your images
6. **Home Page**: Visit `/` to see recent uploads from all users

## Application Structure

```
app/
├── __init__.py              # Package marker
├── app.py                   # Main Flask application
├── config.py                # Configuration settings
├── cognito_auth.py          # Cognito authentication helper
├── s3_storage.py            # S3 storage operations
├── dynamodb_metadata.py     # DynamoDB metadata operations
├── templates/               # HTML templates
│   ├── base.html           # Base template with navigation
│   ├── index.html          # Home page
│   ├── login.html          # Login page
│   ├── register.html       # Registration page
│   ├── confirm.html        # Email confirmation page
│   ├── upload.html         # Image upload page
│   └── gallery.html        # User gallery page
└── static/                  # Static files
    └── style.css           # Custom CSS styles
```

## AWS IAM Permissions

The application requires the following AWS IAM permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-idp:SignUp",
        "cognito-idp:ConfirmSignUp",
        "cognito-idp:InitiateAuth",
        "cognito-idp:GetUser"
      ],
      "Resource": "arn:aws:cognito-idp:*:*:userpool/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/image-metadata"
    }
  ]
}
```

## Security Notes

- The `SECRET_KEY` should be a strong random string in production
- Never commit the `.env` file with actual credentials
- Use HTTPS in production to protect user credentials
- Consider implementing rate limiting for authentication endpoints
- Implement proper CORS settings if using the API from a different domain
- The app uses session-based authentication; consider using JWT for API access

## Troubleshooting

### Cognito Authentication Errors
- Ensure the user pool allows `USER_PASSWORD_AUTH` flow
- Verify the client secret is correctly configured
- Check that the password meets Cognito's password policy requirements

### S3 Upload Errors
- Verify the S3 bucket exists and you have write permissions
- Check that the AWS credentials have the necessary S3 permissions
- Ensure the bucket is in the same region as configured

### DynamoDB Errors
- Verify the table exists with the correct name
- Ensure the partition key is `image_id` (String type)
- Check that the AWS credentials have DynamoDB permissions

## License

This project is for educational purposes as part of the CSD126 AWS Container course.
