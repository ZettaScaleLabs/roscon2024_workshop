#!/bin/bash

IMAGE_NAME=${IMAGE_NAME:-zettascaletech/roscon2024_workshop}

BASE_DIR=`dirname $0`
cd `dirname $0`
BASE_DIR=`pwd`
cd - > /dev/null

docker build -t ${IMAGE_NAME} -f ${BASE_DIR}/Dockerfile ${BASE_DIR}
