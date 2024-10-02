#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME
