#!/bin/bash

# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Restart the container
    docker container restart "$CONTAINER_NAME"
else
    # Container doesn't exist
    echo "Error: Container $CONTAINER_NAME doesn't exist. You should run create_container.sh"
    exit 1
fi