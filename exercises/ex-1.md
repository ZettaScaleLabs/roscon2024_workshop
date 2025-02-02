# Exercise 1 - Zenoh router and ROS Nodes

The primary role of the Zenoh router is to act as a discovery service for ROS nodes running on the same host.
When a node starts, it automatically tries to connect to the local Zenoh router. If the connection fails, the node waits until the router becomes available. The router shares the locators (IP + port) of each node with others, allowing them to automatically establish peer-to-peer connections. Once nodes are connected, they no longer need the router to communicate with each other.

## Simple Talker/Listener Test

To test this, open three different terminals within the same container (using the `login_container.sh` script under the `docker` directory) and run the `demo_nodes_cpp` package's `talker` and `listener`:

1. Start the Zenoh router: `ros2 run rmw_zenoh_cpp rmw_zenohd`
2. Run the talker: `ros2 run demo_nodes_cpp talker`
3. Run the listener (it should receive messages from the talker): `ros2 run demo_nodes_cpp listener`
4. Press `CTRL+C` to stop the Zenoh router. The talker and listener will continue exchanging messages without the router.

> [!NOTE]
> The router may be started after the Nodes! Each Node periodically tries to connect to the router.
> As soon as the router discovers the Nodes, it propagates their endpoints to each other via a gossip protocol
> and each peer establish a direct connection with each other peer.

<p align="center"><img src="pictures/talker-listener.png"  height="250" alt="talker-listener"/></p>

## Bonus - Service, Action and Introspection

You can also test with a ROS service:

- Server: `ros2 run demo_nodes_cpp add_two_ints_server`
- Client: `ros2 run demo_nodes_cpp add_two_ints_client`

And with an Action:

- Action server: `ros2 run action_tutorials_cpp fibonacci_action_server`
- Action client: `ros2 run action_tutorials_cpp fibonacci_action_client`

Additionally, you can use the `ros2` command-line tool to inspect the system:

- List nodes: `ros2 node list`
- List topics: `ros2 topic list`
- List services: `ros2 service list`
- List actions: `ros2 action list`

Even if the Zenoh router is stopped, the `ros2` command-line tool will continue to function.
Why?

<details>
<summary>Answer</summary>

When you run a `ros2` command for the first time, it starts the ROS 2 daemon, which is a regular ROS node. This node connects peer-to-peer with other nodes, acts as a cache of the ROS graph, and can directly respond to queries from the `ros2` command-line tool.

</details>

---
[Next exercise ➡️](ex-2.md)
