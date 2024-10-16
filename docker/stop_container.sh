#!/bin/bash

# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Stop the container
    docker container stop "$CONTAINER_NAME" > /dev/null
else
    echo "Error: Container $CONTAINER_NAME is not running."
    exit 1
fi
