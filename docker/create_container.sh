#!/bin/bash

# Docker image name
IMAGE=${IMAGE:-zettascaletech/roscon2024_workshop}
# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

# Zenoh exposed port
EXPOSED_PORT=${EXPOSED_PORT:-7447}

# Get absolute path to base directory (roscon2024_workshop/ dir)
BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)

if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Container already exists
    echo "Error: Container $CONTAINER_NAME already exists."
else
    # Run in background a container named $CONTAINER_NAME from image $IMAGE.
    # Configured with:
    #  - the display redirection to the host's display
    #  - the use of host networking
    #  - a volume mounting host's roscon2024_workshop/zenoh_confs/ to /ros_ws/zenoh_confs
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        docker run -it --init -d \
            --name "$CONTAINER_NAME" \
            -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
            -e DISPLAY=host.docker.internal:0 \
            -p $EXPOSED_PORT:$EXPOSED_PORT/tcp \
            -p $EXPOSED_PORT:$EXPOSED_PORT/udp \
            "$IMAGE"
    else
         docker run -it --init -d \
            --name "$CONTAINER_NAME" \
            --net host \
            -v "$BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs" \
            -e DISPLAY=host.docker.internal:0 \
            "$IMAGE"
    fi
fi
