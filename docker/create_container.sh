#!/bin/bash

IMAGE=${IMAGE:-roscon2024_workshop}
CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR/..
BASE_DIR=`pwd`
cd - > /dev/null

docker run -it \
    --init \
    -d \
    --name $CONTAINER_NAME \
    -e DISPLAY=host.docker.internal:0 \
    -v $BASE_DIR/zenoh_confs:/ros_ws/zenoh_confs \
    $IMAGE
