#!/bin/bash

IMAGE=${IMAGE:-zettascaletech/roscon2024_workshop}
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)

docker run -it --init -d \
    --name "$CONTAINER_NAME" \
    -e DISPLAY=host.docker.internal:0 \
    -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
    "$IMAGE"
