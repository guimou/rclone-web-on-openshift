#!/bin/bash
if [[ $(ps -aux | grep rclone | grep rcd) ]]; then
    echo "Status: 200"
    echo "Content-type: text/html"
    echo
    echo  "<html><body>Rclone is up!</body></html>"
else
    echo "Status: 404"
    echo "Content-type: text/html"
    echo ""
    echo "<html><body>Rclone is not running!</body></html>"
fi