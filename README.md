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
* Scripts and utilities: Simplifying container management and environment setup.

Get ready to dive into the exciting world of ROS 2 networking with Zenoh!

## Environment

All the workshop is using Docker containers, so you need a host running Docker. `amd64` or `arm64` architectures are both supported.

### Docker image installation

The simplest is to pull it from Docker hub:
```bash
docker pull zettascaletech/roscon2024_workshop
```

You can also build it yourself running the provided `build_image.sh` script:
```bash
./docker/build_image.sh
```
The image will be named `roscon2024_workshop` or with the `$IMAGE_NAME` environment variable if defined.

The image have ROS 2 Jazzy Jalisco (core) installed with the demo ROS 2 packages already available. It also has a workspace under `/ros_ws` with `rmw_zenoh` already built and installed from sources. Both Jazzy and workspace environments are automatically loaded at `bash` startup (see `/root/.bashrc` file).

### Docker container usage

Some scripts are available under `docker` directory to help you with container management:
- Run [`./docker/create_container.sh`](docker/create_container.sh) to create a new container named `roscon2024_workshop` or with the `$CONTAINER_NAME` environment variable if defined.
  The container uses the host network (option `--net host`).  
  Some important directories in this container:
  - `/ros_ws`: the ROS workspace
  - `/ros_ws/src/rmw_zenoh`: `rmw_zenoh` sources (it's already built and installed in the workspace)
  - `/ros_ws/zenoh_confs`: a volume corresponding to the `zenoh_confs/` directory in this reporitory

- Run [`./docker/login_container.sh`](docker/login_container.sh) to start a bash shell within the container
- Run [`./docker/restart_container.sh`](docker/restart_container.sh) to restart the container
- Run [`./docker/stop_container.sh`](docker/stop_container.sh) to stop the container
- Run [`./docker/rm_container.sh`](docker/rm_container.sh) to delete the container
- Run [`./docker/rm_image.sh`](docker/rm_image.sh) to delete the image

---

## Exercises

### Exercise 0 - Pull and build rmw_zenoh
<details>
<summary>This step is optional...</summary>

...since rmw_zenoh sources are already pulled from a recent version in `/ros_ws/src/rmw_zenoh` and build and installed.

However, you can refresh and re-build rmw_zenoh from sources running the following commands:
- `cd /ros_ws/src/rmw_zenoh`
- `git pull`
- `cd /ros_ws`
- `colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release`

</details>

### [Exercise 1 - Zenoh router and ROS Nodes](exercises/ex-1.md)

### [Exercise 2 - Routers connections](exercises/ex-2.md)

### [Exercise 3 - Remote connection via the Cloud](exercises/ex-3.md)
