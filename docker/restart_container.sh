#!/bin/bash

set -xe

CONTAINER_NAME=${CONTAINER_NAME:-workshop_roscon2024}

docker container restart "$CONTAINER_NAME" > /dev/null
