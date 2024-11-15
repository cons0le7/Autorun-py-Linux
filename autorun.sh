#!/bin/bash

# Replace YOUR_SCRIPT.py with the name of your Python script.
YOUR_SCRIPT="YOUR_SCRIPT.py"

# Replace YOUR_SVC_NAME with the service name you'd like to use.
# Must not conflict with any existing service names.
SERVICE_NAME="YOUR_SVC_NAME"

SCRIPT_DIR="$(dirname "$0")"
SCRIPT_PATH="$SCRIPT_DIR/$YOUR_SCRIPT"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: $SCRIPT_PATH does not exist."
    exit 1
fi

SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

echo "[Unit]
Description=null
[Service]
Type=simple
ExecStart=/usr/bin/python3 $SCRIPT_PATH
User=root
[Install]
WantedBy=multi-user.target" | sudo tee $SERVICE_FILE > /dev/null

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME.service

echo "Success. The script will run at startup with superuser permissions."
