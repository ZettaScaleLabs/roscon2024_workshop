#!/bin/bash

# Docker image name
IMAGE=${IMAGE:-zettascaletech/roscon2024_workshop}
# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}
# Host port to be mapped on Zenoh router's port inside the container
ROUTER_PORT=${ROUTER_PORT:-7447}

# Get absolute path to base directory (roscon2024_workshop/ dir)
BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)

if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Container already exists
    echo "Error: Container $CONTAINER_NAME already exists."
else
    # Run in background a container named $CONTAINER_NAME from image $IMAGE.
    # Configured with:
    #  - a volume mounting host's roscon2024_workshop/zenoh_confs/ to /ros_ws/zenoh_confs
    #  - the host port $ROUTER_PORT mapped to the container's port 7447 (default router TCP and UDP port)
    docker run -it --init -d \
        --name "$CONTAINER_NAME" \
        -e DISPLAY=host.docker.internal:0 \
        -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
        -p "$ROUTER_PORT:7447" \
        "$IMAGE"
fi
