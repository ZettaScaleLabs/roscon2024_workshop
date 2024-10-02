#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

docker container restart $CONTAINER_NAME
