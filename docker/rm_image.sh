#!/bin/bash

# Docker image name
IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2024_workshop}

if docker images | grep -q "$IMAGE_NAME"; then
    # Remove the Docker image
    docker rmi -f "$IMAGE_NAME"
else
    echo "Image $IMAGE_NAME not found."
fi