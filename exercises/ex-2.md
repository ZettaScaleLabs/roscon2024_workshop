# Exercise 2 - Routers connections

### Preparation

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

### Run

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

---
[Next exercise ➡️](ex-3.md)