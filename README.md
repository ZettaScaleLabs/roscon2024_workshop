<div align="center">

  <h1>🐲🇩🇰 Zenoh ROSCon 2024 Workshop</h1>

  <p>
    <strong> Your first steps with Zenoh as an RMW in ROS 2 </strong>
  </p>

  <p>
    <a href="https://choosealicense.com/licenses/epl-2.0/"><img alt="License EPL" src="https://img.shields.io/badge/License-EPL%202.0-blue"/></a>
    <a href="https://opensource.org/licenses/Apache-2.0"><img alt="License EPL" src="https://img.shields.io/badge/License-Apache%202.0-blue.svg"/></a>
  </p>

<sub>Built by the <a href="https://zenoh.io">Zenoh</a> team at <a href="https://www.zettascale.tech">ZettaScale</a> with ❤️</sub>
</div>

## About

Welcome! This repository is part of the `Demystifying ROS 2 Networking` workshop, scheduled to take place on October 21st at ROSCon 2024. It contains all the resources you’ll need to get started with `rmw_zenoh`, the Zenoh middleware for `ROS 2`.

In this hands-on workshop, you’ll explore how to leverage Zenoh as a ROS 2 middleware (RMW) layer. Whether you're new to Zenoh or looking to deepen your understanding of it, this workshop is designed to give you practical insights through simple demonstrations.

What's Included:

* Dockerized environment: Pre-configured for easy setup and reproducibility.
* Simple ROS 2 applications: Designed to showcase the use of rmw_zenoh.
* Scripts and utilities: Simplifying container management, environment setup and configuration files.

Get ready to dive into the exciting world of ROS 2 networking with Zenoh!

## Setup

This workshop runs entirely within Docker containers, so you’ll need a host machine with Docker installed. Both `amd64` and `arm64` architectures are supported.

### Docker image installation

The easiest way to get the image is by pulling it from Docker Hub:

```bash
docker pull zettascaletech/roscon2024_workshop
```

Alternatively, you can clone this repository and build the image yourself using the provided `build_image.sh` script. By default, the image will be named roscon2024_workshop, or you can specify a different name by setting the $IMAGE_NAME environment variable.

```bash
./docker/build_image.sh
```

The image includes ROS 2 Jazzy Jalisco (core) with pre-installed demo ROS 2 packages. It also has a workspace at `/ros_ws` where `rmw_zenoh` is already built and installed from source. Both the ROS 2 Jazzy environment and the workspace will be automatically set up when you start a bash session (see the `/root/.bashrc` file for details).

### Using the Docker Container

The docker directory contains several scripts to help manage the container:

* Run [`./docker/create_container.sh`](docker/create_container.sh) to create a container named `roscon2024_workshop`, or use the `$CONTAINER_NAME` environment variable to specify a custom name. The container will use the host network (`--net host`). Important directories in the container include:
  * `/ros_ws`: The ROS workspace
  * `/ros_ws/src/rmw_zenoh`: The `rmw_zenoh` source code (already built and installed in the workspace)
  * `/ros_ws/zenoh_confs`: A volume mapped to the `zenoh_confs/` directory in this repository
* Run [`./docker/login_container.sh`](docker/login_container.sh) to start a bash shell inside the container
* Run [`./docker/restart_container.sh`](docker/restart_container.sh) to restart the container
* Run [`./docker/stop_container.sh`](docker/stop_container.sh) to stop the container
* Run [`./docker/rm_container.sh`](docker/rm_container.sh) to delete the container
* Run [`./docker/rm_image.sh`](docker/rm_image.sh) to delete the Docker image

## Exercises

### [Exercise 1 - Zenoh router and ROS Nodes](exercises/ex-1.md)

### [Exercise 2 - Routers connections](exercises/ex-2.md)

### [Exercise 3 - Remote connection via the Cloud](exercises/ex-3.md)

### [Exercise 4 - Direct Node connection](exercises/ex-4.md)

### [Exercise 5 - Discovery via UDP multicast](exercises/ex-5.md)
