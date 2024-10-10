# Exercise 2 - Routers connections


The second role of the Zenoh router is to route the traffic for external communications.  
The benefits being:
  - less interconnections between Nodes and thus less network overhead
  - automatic batching of small messages for a better throughput
  - smaller surface of attack (only 1 port open)
  - a single place to configure access control and downsampling

### Configuration

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

### Run

Now you can run the following commands in your respective containers:
- In container A:
  - `ZENOH_ROUTER_CONFIG_URI=/ros_ws/zenoh_confs/ROUTER_CONFIG.json5 ros2 run rmw_zenoh_cpp rmw_zenohd`
  - `ros2 run demo_nodes_cpp talker`
- In container B:
  - `ros2 run rmw_zenoh_cpp rmw_zenohd`
  - `ros2 run demo_nodes_cpp listener`

You can switch the containers running `talker` and `listener`, meaning the interconnection between the routers is well bi-directional.  
You can also check that if you kill a router the communication stops. If your restart it, the communication resumes.

<p align="center"><img src="pictures/talker-listener-2-containers.png"  height="250"/></p>


### Bonus - multiple routers inter-connections

Try to add more connections to other attendees' containers (`connect.endpoints` configuration is a list).
Each of you can run within its container:
- `ros2 topic pub /chatter std_msgs/msg/String "data: Hello from <YOUR_NAME>"` - (replacing `<YOUR_NAME>`)
- `ros2 topic echo /chatter`

Also try different configuration of inter-connections such as a chain:

<p align="center"><img src="pictures/talker-listener-3-containers.png"  height="250"/></p>


### Note - starting another container on the same host

You can run another container with `rmw_zenoh` on the same host, setting the `CONTAINER_NAME` environment variable to another name in all the terminal you'll use for this new container:
```bash
export CONTAINER_NAME="container_2"
./docker/create_container.sh
./docker/login_container.sh
```

However as the containers are configured to use the host network, the routers in each container will conflict on the usage of port `7447`. Therefore you need to configure your 2nd container to use another port for the Zenoh router (e.g. `7448`):

- copy the file `zenoh_confs/DEFAULT_RMW_ZENOH_ROUTER_CONFIG.json5` as `zenoh_confs/CONTAINER_2_ROUTER_CONFIG.json5`
- edit `zenoh_confs/CONTAINER_2_ROUTER_CONFIG.json5` and set the `listen.endpoints` configuration as such:
  ```json5
  listen: {
    endpoints: [
      "tcp/[::]:7448"
    ],
  },
  ```
  In the same file you can configure the connections to other routers in `connect.endpoints` as explained above.
- copy the file `zenoh_confs/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5` as `zenoh_confs/CONTAINER_2_SESSION_CONFIG.json5`
- edit `zenoh_confs/CONTAINER_2_ROUTER_CONFIG.json5` and set the `connect.endpoints` configuration as such:
  ```json5
  connect: {
    endpoints: [
      "tcp/localhost:7448"
    ],
  },
  ```
   This will make each node to connect to the router listening on port `7448`.

In each shell running in your 2nd container, export those environment variables:
```bash
export ZENOH_ROUTER_CONFIG_URI=/ros_ws/zenoh_confs/CONTAINER_2_ROUTER_CONFIG.json5
export ZENOH_SESSION_CONFIG_URI=/ros_ws/zenoh_confs/CONTAINER_2_SESSION_CONFIG.json5
```

---
[Next exercise ➡️](ex-3.md)