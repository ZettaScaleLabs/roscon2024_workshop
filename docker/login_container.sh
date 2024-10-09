#!/bin/bash

# Docker container name (must have been created by the create_container.sh script)
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Start a bash shell in the container
    docker exec -ti "$CONTAINER_NAME" /bin/bash
else
    if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
        # Container exists but is not running
        echo "Error: Container $CONTAINER_NAME is not running. You should run restart_container.sh"
        exit 1
    else
        # Container doesn't exist
        echo "Error: Container $CONTAINER_NAME doesn't exist. You should run create_container.sh"
        exit 1
    fi
fi