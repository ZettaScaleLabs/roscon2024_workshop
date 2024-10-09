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

### 0. Pull and build rmw_zenoh
<details>
<summary>This step is optional...</summary>

...since rmw_zenoh sources are already pulled from a recent version in `/ros_ws/src/rmw_zenoh` and build and installed.

However, you can refresh and re-build rmw_zenoh from sources running the following commands:
- `cd /ros_ws/src/rmw_zenoh`
- `git pull`
- `cd /ros_ws`
- `colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release`

</details>

### 1. Zenoh router and ROS Nodes

The first role of the Zenoh router in ROS 2 is to act as a discovery service for the ROS Nodes running on the same host.  
Each Node automatically tries to connect to the local router at startup, waiting for it if connection fails. The router forwards the locators (IP+port) of each Nodes to other Nodes, so they automatically establish peer-to-peer connection with each other. Once interconnected, 2 Nodes no longer need the router to communicate with each other.

Within the same container, login with 3 different terminals to experiment with `demo_nodes_cpp`'s `talker` and `listener` running:
- `ros2 run demo_nodes_cpp talker`: the talker is waiting for the Zenoh router
- `ros2 run rmw_zenoh_cpp rmw_zenohd`: starts the router - the talker shall now publish
- `ros2 run demo_nodes_cpp listener`: the listener shall receive messages from the talker
- CTRL+C on zenoh router: the talker and listener shall continue to exchange messages

<p align="center"><img src="pictures/talker-listener.png"  height="250"/></p>

### 2. Routers connections

The second role of the Zenoh router is to route the traffic for external communications.  
The benefits being:
  - less interconnections between Nodes and thus less network overhead
  - automatic batching of small messages for a better throughput
  - smaller surface of attack (only 1 port open)
  - a single place to configure access control and downsampling

Partner with another attendee and decide who will connect his container (A) to the other's container (B).  
The attendee with container A must create a configuration file for the router to connect the router in container B:

- copy the file `zenoh_confs/DEFAULT_RMW_ZENOH_ROUTER_CONFIG.json5` as `zenoh_confs/ROUTER_CONFIG.json5`
- edit `zenoh_confs/ROUTER_CONFIG.json5` and set a `connect.endpoints` configuration as such:
  ```json5
  connect: {
    endpoints: [
      "tcp/<host_B_IP>:7447"
    ],
  },
  ```
  Where `<host_B_IP>` is the IP address of the host running the container B.

The attendee with container B has nothing to do. By default the Zenoh router is listening to incoming TCP connections on port 7447 via any network interface.
And the container was created with a mapping of host' port 7447 to container port 7447.

Now you can run the following commands:
- In container A:
  - `ZENOH_ROUTER_CONFIG_URI=/ros_ws/zenoh_confs/ROUTER_CONFIG.json5 ros2 run rmw_zenoh_cpp rmw_zenohd`
  - `ros2 run demo_nodes_cpp talker`
- In container B:
  - `ros2 run rmw_zenoh_cpp rmw_zenohd`
  - `ros2 run demo_nodes_cpp listener`

You can switch the containers running `talker` and `listener`, meaning the interconnection between the routers is well bi-directional.  
You can also check that if you kill a router the communication stops. If your restart it, the communication resumes.

<p align="center"><img src="pictures/talker-listener-2-containers.png"  height="250"/></p>
