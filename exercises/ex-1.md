# Exercise 1 - Zenoh router and ROS Nodes

The first role of the Zenoh router in ROS 2 is to act as a discovery service for the ROS Nodes running on the same host.  
Each Node automatically tries to connect to the local router at startup, waiting for it if connection fails. The router forwards the locators (IP+port) of each Nodes to other Nodes, so they automatically establish peer-to-peer connection with each other. Once interconnected, 2 Nodes no longer need the router to communicate with each other.

### Simple talker/listener test

Within the same container, login with 3 different terminals to experiment with `demo_nodes_cpp`'s `talker` and `listener` running:
- `ros2 run demo_nodes_cpp talker`: the talker is waiting for the Zenoh router
- `ros2 run rmw_zenoh_cpp rmw_zenohd`: starts the router - the talker shall now publish
- `ros2 run demo_nodes_cpp listener`: the listener shall receive messages from the talker
- CTRL+C on zenoh router: the talker and listener shall continue to exchange messages

<p align="center"><img src="pictures/talker-listener.png"  height="250"/></p>


### Bonus - Service, Action and introspection

You can run a similar test with a Service:
- `ros2 run demo_nodes_cpp add_two_ints_server`
- `ros2 run demo_nodes_cpp add_two_ints_client`

And an Action:
- `ros2 run action_tutorials_cpp fibonacci_action_server`
- `ros2 run action_tutorials_cpp fibonacci_action_client`

You can also test the `ros2` command-line tool:
- `ros2 node list`
- `ros2 topic list`
- `ros2 service list`
- `ros2 action list`

Note that if the router is stopped, the `ros2` command-line tool keeps working.  
Why ?

<details>
<summary>Response</summary>

Because on first run the `ros2` command started the ROS 2 daemon. This is a regular ROS Node, connected in peer-to-peer to the other Nodes. It acts as a cache of the ROS graph and can directly reply to the queries from `ros2` command.

</details>

---
[Next exercise ➡️](ex-2.md)