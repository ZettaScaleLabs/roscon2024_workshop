#!/bin/bash

set -xe

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    docker exec -ti "$CONTAINER_NAME" /bin/bash
else
    echo "Error: Container $CONTAINER_NAME is not running."
    exit 1
fi