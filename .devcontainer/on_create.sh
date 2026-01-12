# This script gets run as devcontainer post-create command

set -eux  # Exit on error and print commands

# Make sure AWS credentials file exists with correct permissions
mkdir -p .aws
touch .aws/credentials
chmod 600 .aws/credentials

# Install Python packages
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip

echo '
# Auto-activate project venv if present
if [ -f /workspaces/aws-deployment-project/.venv/bin/activate ]; then
    source /workspaces/aws-deployment-project/.venv/bin/activate
fi
' >> ~/.bashrc