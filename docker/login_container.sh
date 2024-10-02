#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-roscon2024_workshop}

docker exec -ti $CONTAINER_NAME /bin/bash
