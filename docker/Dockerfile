#
# Copyright (c) 2024 ZettaScale Technology
#
# This program and the accompanying materials are made available under
# the terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# SPDX-License-Identifier: Apache-2.0
#
# Contributors:
#   ZettaScale Zenoh Team, <zenoh@zettascale.tech>
#

ARG ROS_DISTRO=jazzy
ARG RMW_ZENOH_BRANCH=dev/1.0.0-revert-not-shutdown-contained-entities

ARG BASE_IMAGE=ros:${ROS_DISTRO}-ros-core

FROM ${BASE_IMAGE} AS ros_base

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-ament-cmake-vendor-package \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-action-tutorials-cpp \
    ros-${ROS_DISTRO}-action-tutorials-py \
    ros-${ROS_DISTRO}-turtlesim \
    cargo \
    clang \
    ros-dev-tools \
    vim \
    iputils-ping iproute2 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ros_ws

FROM ros_base AS build

ARG ROS_DISTRO
ARG RMW_ZENOH_BRANCH

RUN mkdir -p src && \
    cd src && \
    git clone https://github.com/ZettaScaleLabs/rmw_zenoh.git -b $RMW_ZENOH_BRANCH && \
    cd .. && \
    . /opt/ros/${ROS_DISTRO}/setup.sh && \
    rosdep init && rosdep update && \
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

FROM ros_base

COPY --from=build /ros_ws/src /ros_ws/src
COPY --from=build /ros_ws/install /ros_ws/install

RUN cat <<EOF >> /root/.bashrc
source /ros_ws/install/setup.bash
export RMW_IMPLEMENTATION=rmw_zenoh_cpp
export RUST_LOG=info
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"
export RCUTILS_COLORIZED_OUTPUT=1
EOF

EXPOSE 7447/tcp
EXPOSE 7447/udp

WORKDIR /ros_ws
CMD ["bash"]
