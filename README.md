# AWS Container

This repository provides a Docker container pre-configured with the AWS CLI and other useful tools for managing AWS services. It also includes a Flask-based Image Gallery application that demonstrates integration with AWS Cognito, S3, and DynamoDB.

## Setup

Before using the container, you must have the following installed and working on your machine:
- Docker Desktop
- Git
- Visual Studio Code (VS Code)
  - The "Dev Containers" extension must be installed in VS Code.

Then, follow these steps to set up the container repository:

1. Fork this repository to your GitHub account.
2. Clone your forked repository to your local machine.
3. If you want to be able to synchronize your clone with the original repository, add the original repository as a remote.  E.g. `git add remote template https://github.com/saultcollege-csd126/aws-container.git`.

   To verify that the remote was added, run `git remote -v` and you should see both `origin` (your fork) and `template` (the original repository).

   To synchronize your fork with the original repository in the future, run `git fetch template` followed by `git merge template/main` while on your local `main` branch, and resolve any merge conflicts if necessary.

## Usage

1. Open the repository in VS Code
2. Ensure the project is opened in a Dev Container:
   - If prompted by VS Code, click "Reopen in Container".
   - Alternatively, open the Command Palette (Ctrl+Shift+P), type "Dev Containers: Reopen in Container", and select it.

   > **Note:** The first time you open the container, it may take some time to build and set up the environment. Subsequent openings will be faster.

3. Update the `.aws/credentials` file with your AWS credentials (see AWS Credentials section below) to enable AWS CLI functionality.

4. To test that everything is working, open a terminal in VS Code and run:
   ```bash
   aws sts get-caller-identity
   ```
   You should see a JSON response with your AWS account details.

## AWS Credentials

To use the AWS CLI within the container, you need to provide your AWS credentials. You can do this by creating a file at `.aws/credentials` in the home directory of the container with the following format:

```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
aws_session_token = YOUR_SESSION_TOKEN # (if applicable)
```

### How to obtain AWS Credentials

#### Using an AWS Academy Lab Environment

1. Log in to your AWS Academy account.
2. Navigate to any lab, and launch it.
3. Once the lab environment is running, click on the "AWS Details" button.
4. Click the AWS CLI "Show" button.
5. Copy the ENTIRE contents of the displayed credentials and paste them into your `.aws/credentials` file in the container.

#### Using an AWS Academy Sandbox Environment

1. Log in to your AWS Academy account.
2. Navigate to the Sandbox section and launch a Sandbox environment.
3. Once the Sandbox environment is running, click on the "Details" button, then click the "Show" button.
4. Click the AWS CLI "Show" button.
5. Copy the ENTIRE contents of the displayed credentials and paste them into your `.aws/credentials` file in the container.

## Flask Image Gallery Application

This repository includes a Flask-based image gallery application that demonstrates integration with AWS services.

### Features

1. **User Authentication**: Login and registration via AWS Cognito user pool
2. **Image Upload**: Authenticated users can upload images (stored in S3)
3. **Metadata Storage**: Image metadata (owner, created_at, status) stored in DynamoDB
4. **Image Management**: Users can view and delete their uploaded images
5. **Public Gallery**: Home page displays recently uploaded images from all users

### Quick Start

1. **Set up AWS resources** (Cognito, S3, DynamoDB):
   ```bash
   ./setup_aws.sh
   ```
   This script will create the necessary AWS resources and output configuration values.

2. **Create a `.env` file** with the configuration values from the setup script, or copy from the example:
   ```bash
   cp .env.example .env
   # Edit .env with your AWS resource details
   ```

3. **Run the application**:
   ```bash
   ./run_app.sh
   ```
   Or manually:
   ```bash
   source .venv/bin/activate
   pip install -r requirements.txt
   python -m app.app
   ```

4. **Access the application**: Open your browser to `http://localhost:5000`

### Documentation

For detailed information about the Flask application, including:
- Application architecture
- AWS setup instructions
- Required IAM permissions
- Troubleshooting

See the [Flask App README](app/README.md).