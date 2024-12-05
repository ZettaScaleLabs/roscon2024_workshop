#!/bin/bash

# Name of the Docker image to build
IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2024_workshop}

# Get absolute path to base directory (roscon2024_workshop/docker/ dir)
BASE_DIR=$(cd "$(dirname "$0")" && pwd)

if [ ! "$(docker images -q "${IMAGE_NAME}")" ]; then
    echo "${IMAGE_NAME} does not exist. Creating..."
    docker build -t "$IMAGE_NAME":dev-1.0.0 -f "$BASE_DIR/Dockerfile" "$BASE_DIR"
else
    echo "Ignoring, $IMAGE_NAME already exists."
fi
