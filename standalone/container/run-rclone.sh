#!/usr/bin/env bash

# Load bash libraries
SCRIPT_DIR=$(dirname -- "$0")
source ${SCRIPT_DIR}/utils/*.sh

# Create rclone config folder if it does not exist
mkdir -p /opt/app-root/src/.rclone-config

# Start server
start_process rclone rcd \
    --rc-web-gui \
    --rc-web-gui-no-open-browser \
    --rc-user=$RC_ADMIN_USER \
    --rc-pass=$RC_ADMIN_PASS \
    --rc-serve \
    --cache-dir=/tmp \
    --rc-addr=:5572 \
    --s3-v2-auth \
    --config=/opt/app-root/src/.rclone-config/rclone.conf
