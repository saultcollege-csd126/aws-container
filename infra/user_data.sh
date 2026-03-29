#!/bin/bash

# -e : exit immediately on error
# -u : treat unset variables as an error
# -x : print the commands as they get executed (so they show up in GitHub Actions logs)
set -eux


# Update system packages and install needed software
dnf update -y
dnf install -y git python3.13

# Where to install the app
APP_DIR=/home/ec2-user/xpix

mkdir -p $APP_DIR

# Clone your application repository (replace with your repo URL)
git clone !!!Your clone URL here!!! $APP_DIR

cd $APP_DIR

# Setup Python virtual environment and install dependencies
python3 -m venv .venv
source .venv/bin/activate
pip install -r app/flask/requirements.txt
pip install gunicorn

deactivate # Exit the Python virtual environment

# Set the owner of the repo folder to be the user account that will ultimately run the app
# MUST COME AFTER THE clone and python steps, since those steps will create files that are owned by root, 
# and we want to change the ownership of those files to be owned by the ec2-user account instead.
chown -R ec2-user:ec2-user $APP_DIR


# --- Create systemd service ---
# This creates a systemd service that will run our Flask app using Gunicorn.
# The service will run as the ec2-user, and it will start automatically on boot.
cat <<EOF > /etc/systemd/system/xpix.service
[Unit]
Description=Gunicorn service for XPix app
After=network.target

[Service]
User=ec2-user
Group=ec2-user
WorkingDirectory=$APP_DIR/app/flask
Environment="PATH=$APP_DIR/.venv/bin"
ExecStart=$APP_DIR/.venv/bin/gunicorn -b 127.0.0.1:8000 src.app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# --- Start + enable service ---
systemctl daemon-reload
systemctl enable xpix
systemctl start xpix