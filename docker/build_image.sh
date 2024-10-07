#!/bin/bash

set -xe

IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2024_workshop}

BASE_DIR=$(cd "$(dirname "$0")" && pwd)

if [ ! "$(docker images -q "${IMAGE_NAME}")" ]; then
    echo "${IMAGE_NAME} does not exist. Creating..."
    docker build -t "$IMAGE_NAME" -f "$BASE_DIR/Dockerfile" "$BASE_DIR"
else
    echo "Ignoring, $IMAGE_NAME already exists."
fi
