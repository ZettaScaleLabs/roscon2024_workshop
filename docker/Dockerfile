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
ARG RMW_ZENOH_BRANCH=rolling

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
    iputils-ping && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ros_ws

FROM ros_base AS build

ARG ROS_DISTRO
ARG RMW_ZENOH_BRANCH

RUN mkdir -p src && \
    cd src && \
    git clone https://github.com/ros2/rmw_zenoh.git -b $RMW_ZENOH_BRANCH && \
    cd .. && \
    . /opt/ros/${ROS_DISTRO}/setup.sh && \
    rosdep init && rosdep update && \
    rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

FROM ros_base

COPY --from=build /ros_ws/src /ros_ws/src
COPY --from=build /ros_ws/install /ros_ws/install

RUN echo "source /ros_ws/install/setup.bash" >> /root/.bashrc && \
    echo "export RMW_IMPLEMENTATION=rmw_zenoh_cpp" >> /root/.bashrc

EXPOSE 7447/tcp
EXPOSE 7447/udp

WORKDIR /ros_ws
CMD ["bash"]
