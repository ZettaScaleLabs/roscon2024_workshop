#!/bin/bash

set -xe

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

if docker ps -f name="$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
    docker container kill "$CONTAINER_NAME" > /dev/null
fi

docker container rm "$CONTAINER_NAME" > /dev/null