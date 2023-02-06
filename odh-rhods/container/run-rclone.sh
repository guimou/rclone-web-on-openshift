#!/usr/bin/env bash

# Load bash libraries
SCRIPT_DIR=$(dirname -- "$0")
source ${SCRIPT_DIR}/utils/*.sh

# Start nginx and fastcgiwrap
run-nginx.sh &
spawn-fcgi -s /var/run/fcgiwrap.socket -M 766 /usr/sbin/fcgiwrap

# Create rclone config folder if it does not exist
mkdir -p /opt/app-root/src/.rclone-config

# Initilize access logs for culling
echo '[{"id":"code-server","name":"code-server","last_activity":"'$(date -Iseconds)'","execution_state":"running","connections":1}]' > /var/log/nginx/rclone.access.log

# Start server
start_process rclone rcd \
    --rc-web-gui \
    --rc-web-gui-no-open-browser \
    --rc-no-auth \
    --rc-serve \
    --cache-dir=/tmp \
    --rc-addr=:5572 \
    --s3-v2-auth \
    --config=/opt/app-root/src/.rclone-config/rclone.conf
