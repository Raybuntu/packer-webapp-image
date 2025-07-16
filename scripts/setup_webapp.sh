#!/bin/bash
set -e

# echo for debugging purposes
echo "Starting webapp setup..."
echo "Repository URL: $WEBAPP_REPO_URL"

# Check if Repor url is set
if [ -z "${WEBAPP_REPO_URL:-}" ]; then
    echo "ERROR: WEBAPP_REPO_URL is not set"
    exit 1
fi

# Create system user for running the webapp service
sudo useradd --system --no-create-home --shell /usr/sbin/nologin webapp || true

# System basics: update, upgrade, timezone, locale, keyboard layout
sudo apt-get update -y
sudo apt-get upgrade -y
sudo timedatectl set-timezone Europe/Berlin
sudo localectl set-locale LANG=de_DE.UTF-8
sudo localectl set-keymap de-nodeadkeys

# Disable unattended-upgrades.
sudo systemctl stop unattended-upgrades
sudo systemctl disable unattended-upgrades

# Install webapp dependencies
sudo apt-get install -y nginx git python3-flask python3-requests python3-pip
sudo pip3 install google-auth google-api-python-client

# Clone webapp repository
sudo git clone "$WEBAPP_REPO_URL" /opt/webapp

# Remove .git directory for security and cleanup
sudo rm -rf /opt/webapp/.git

# Set permissions and ownership for webapp directory
sudo chown -R webapp:webapp /opt/webapp
sudo chmod -R 750 /opt/webapp

# Set env file
echo "REGION=${REGION}" | sudo tee /etc/webapp.env
echo "MIG_NAME=${MIG_NAME}" | sudo tee -a /etc/webapp.env

# Install systemd service for the webapp
sudo cp /opt/webapp/webapp.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable webapp
sudo systemctl start webapp

# Configure nginx for the webapp
sudo rm -f /etc/nginx/sites-enabled/default
sudo cp /opt/webapp/webapp.conf /etc/nginx/sites-available/webapp
sudo ln -sf /etc/nginx/sites-available/webapp /etc/nginx/sites-enabled/webapp
sudo systemctl restart nginx
