#!/bin/bash

set -xe

IMAGE_NAME=${IMAGE_NAME:-zettascaletech/workshop_roscon2024}

if docker images | grep -q "$IMAGE_NAME"; then
    docker rmi -f "$IMAGE_NAME"
else
    echo "Image $IMAGE_NAME not found."
fi