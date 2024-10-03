#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

docker container kill "$CONTAINER_NAME"
docker container rm "$CONTAINER_NAME"
