#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
docker build -t novnc-ros2 $SCRIPT_DIR/
