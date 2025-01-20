# Exercise 4 - Direct Node Connection

Deploying a Zenoh router on each host isn't always necessary. In some cases, you may prefer a direct connection between your robot and a single remote Node (e.g., `rviz2`).

This can be achieved by configuring the Node's Zenoh session to connect directly to the robot’s router, as shown below:

<p align="center"><img src="pictures/node-to-router-connectivity.png"  height="250" alt="node-to-router-connectivity"/></p>

## Configuration

Partner with another attendee and decide who will connect their container (A) to the other's container (B).
The attendee with container B needs to create a configuration file for the Listener Node to connect to the router in container A:

1. Copy `zenoh_confs/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5` to `zenoh_confs/SESSION_CONFIG.json5`
2. Edit `zenoh_confs/SESSION_CONFIG.json5` as such:

   - Change the `mode` from `"peer"` to `"client"` as such:

     ```json5
     mode: "client",
     ```

   - And the set a `connect.endpoints` configuration as follows (Replace `<host_A_IP>` with the IP address of the host running container A):

    ```json5
    connect: {
      endpoints: [
        "tcp/<host_A_IP>:7447"
      ],
    },
    ```

The attendee with container A has nothing to do. By default the Zenoh router is listening to incoming TCP connections on port 7447 via any network interface.

> [!NOTE]
> The reason to change the Listener mode to client is that with by default for ROS 2 the router is configured with
> `routing.router.peers_failover_brokering: false`, meaning the router will consider that each peer directly connected to him
> are also able to establish peer-to-peer connection. Thus it will not route data between the peers.
>
> But that's not the case here, the peers cannot establish direct connection with each other because they are listening on `localhost` only!
> Configuring the Listener in `client` mode forces the router to route data to him, as a `client` maintains only 1 connection
> (the one to the router).
>
> Another solution could be to set `routing.router.peers_failover_brokering: true` for the router, keeping Listener's mode as `peer`.
> The drawback would be additional management overhead for the router and extra messages during system startup which could penalize
> a large system with a lot of Nodes.

## Run

Now, run the following commands in each container:

- In container A:
  - Start the router: `ros2 run rmw_zenoh_cpp rmw_zenohd`
  - Start the talker: `ros2 run demo_nodes_cpp talker`
- In container B:
  - Start the listener: `ZENOH_SESSION_CONFIG_URI=/ros_ws/zenoh_confs/SESSION_CONFIG.json5 ros2 run demo_nodes_cpp listener`

## Bonus

What happens if you stop the router in container A, and why ?

<details>
<summary>Answer</summary>

The communication between the Talker and the Listener stops!
The reason is that there was no peer-to-peer connectivity established between the Talker and the Listener, since each one is by default listening for incoming connection only on their respective `localhost` interface. See the `listen.endpoints` configuration in [zenoh_confs/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5](../zenoh_confs/DEFAULT_RMW_ZENOH_SESSION_CONFIG.json5).

</details>

How to fix this ?

<details>
<summary>Answer</summary>

You need to configure the Listener node in container B to listen for incoming connections on all network interfaces, not just `localhost`:

- Edit `zenoh_confs/SESSION_CONFIG.json5` and set `listen.endpoints` configuration as follows:

    ```json5
    listen: {
      endpoints: [
        "tcp/[::]:0"
      ],
    },
    ```

The Zenoh gossip protocol will do the rest: forwarding the Listener endpoint to the Talker, and the Talker will automatically connect to the Listener.

<p align="center"><img src="pictures/node-to-node-connectivity.png"  height="300" alt="node-to-node-connectivity"/></p>

</details>

---
[Next exercise ➡️](ex-5.md)
