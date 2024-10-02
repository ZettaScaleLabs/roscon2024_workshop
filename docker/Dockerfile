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

# Use desktop-full image to be ready for any use case!
# If you want smaller image, change the base image with one of those:
# https://github.com/sloretz/ros_oci_images?tab=readme-ov-file#about-the-images
ARG FROM=ghcr.io/sloretz/ros:${ROS_DISTRO}-desktop-full

FROM ${FROM} AS ros_base

# Install ROS build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-pytest-cov \
    python3-flake8-blind-except \
    python3-flake8-class-newline \
    python3-flake8-deprecated \
    python3-pytest-repeat \
    python3-pytest-rerunfailures \
    ros-dev-tools \
    ros-${ROS_DISTRO}-ament-cmake-vendor-package \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    cargo \
    vim iputils-ping \
    && rm -rf /var/lib/apt/lists/*


FROM ros_base AS build

# Must redeclare so that value is available after FROM statement.
ARG ROS_DISTRO
ARG RMW_ZENOH_BRANCH

# checkout and build rmw_zenoh
RUN mkdir -p /ros_ws/src && cd /ros_ws/src && \
    git clone https://github.com/ros2/rmw_zenoh.git -b $RMW_ZENOH_BRANCH && \
    cd /ros_ws && \
    . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release


FROM ros_base

COPY --from=build  /ros_ws/src /ros_ws/src
COPY --from=build  /ros_ws/install /ros_ws/install

RUN echo ". /ros_ws/install/setup.bash" >> /root/.bashrc && \
    echo "export RMW_IMPLEMENTATION=rmw_zenoh_cpp" >> /root/.bashrc

# expose TCP and UDP/QUIC ports used by the Zenoh router for incoming connections
EXPOSE 7447/tcp
EXPOSE 7447/udp

CMD ["bash"]
WORKDIR "/ros_ws"