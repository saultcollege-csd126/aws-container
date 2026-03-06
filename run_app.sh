#!/bin/bash
# Helper script to run the Flask Image Gallery application

set -e  # Exit on error

echo "======================================"
echo "Flask Image Gallery - Run Script"
echo "======================================"
echo ""

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠ Warning: .env file not found!"
    echo "Please create a .env file with your AWS credentials."
    echo "You can use .env.example as a template:"
    echo "  cp .env.example .env"
    echo ""
    echo "Or run the setup script to create AWS resources:"
    echo "  ./setup_aws.sh"
    echo ""
    exit 1
fi

# Check if virtual environment exists
if [ ! -d .venv ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
    echo "✓ Virtual environment created"
fi

# Activate virtual environment
source .venv/bin/activate

# Install requirements if needed
if ! python -c "import flask" 2>/dev/null; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
    echo "✓ Dependencies installed"
fi

# Load environment variables safely
set -a
source .env
set +a

echo "✓ Environment configured"
echo ""
echo "Starting Flask application..."
echo "The application will be available at http://localhost:5000"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run the Flask app
python -m app.app
