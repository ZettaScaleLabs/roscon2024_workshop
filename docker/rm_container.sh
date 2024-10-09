#!/bin/bash

# Docker container name
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Stop the container at first
    docker container kill "$CONTAINER_NAME" > /dev/null
fi


if docker container ls -a -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    # Remove the container
    docker container rm "$CONTAINER_NAME" > /dev/null
else
    # Container doesn't exist
    echo "Error: Container $CONTAINER_NAME doesn't exist."
    exit 1
fi
