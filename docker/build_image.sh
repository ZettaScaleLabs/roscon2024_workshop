#!/bin/bash

IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2024_workshop}

BASE_DIR=$(cd "$(dirname "$0")" && pwd)

docker build -t "$IMAGE_NAME" -f "$BASE_DIR/Dockerfile" "$BASE_DIR"
