#!/bin/bash

set -xe

IMAGE=${IMAGE:-zettascaletech/roscon2024_workshop}
CONTAINER_NAME=${CONTAINER_NAME:-workshop_roscon2024}

BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    echo "Error: Container $CONTAINER_NAME already exists."
else
    docker run -it --init -d \
        --name "$CONTAINER_NAME" \
        -e DISPLAY=host.docker.internal:0 \
        -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
        "$IMAGE"
fi
