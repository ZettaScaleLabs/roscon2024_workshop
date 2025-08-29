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
ARG RMW_ZENOH_BRANCH=jazzy

ARG BASE_IMAGE=ros:${ROS_DISTRO}-ros-core

FROM ${BASE_IMAGE}

# Install rmw_zenoh, some demos/tutos for the workshop
# and some usefull tools (vim, ping...)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-rmw-zenoh-cpp \
    ros-${ROS_DISTRO}-ament-cmake-vendor-package \
    ros-dev-tools \
    ros-${ROS_DISTRO}-tracetools \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py \
    ros-${ROS_DISTRO}-action-tutorials-cpp \
    ros-${ROS_DISTRO}-action-tutorials-py \
    ros-${ROS_DISTRO}-turtlesim \
    vim \
    iputils-ping iproute2 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY rmw_zenoh_env.bash /

# Make /root/.bashrc to load /rmw_zenoh_env.bash for `docker exec` commands to have proper env
RUN echo 'source /rmw_zenoh_env.bash' >> /root/.bashrc

EXPOSE 7447/tcp
EXPOSE 7447/udp

WORKDIR /ros_ws
CMD ["bash"]
