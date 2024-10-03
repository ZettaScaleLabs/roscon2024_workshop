#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -q -f name="$CONTAINER_NAME" > /dev/null; then
    docker exec -ti "$CONTAINER_NAME" /bin/bash
else
    echo "Error: Container $CONTAINER_NAME is not running."
    exit 1
fi
