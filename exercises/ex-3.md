# Exercise 3 - Remote connection via the Cloud

A router deployed in a Cloud with a public IP address can be used as a relay between 2 rmw_zenoh systems.

<p align="center"><img src="pictures/cloud-connectivity.png"  height="350"/></p>


### Configuration

For this workshop we deployed a Zenoh router on `roscon.zenoh.io`.

Edit your `zenoh_confs/ROUTER_CONFIG.json5` again to set this `connect.endpoints` configuration:
```json5
  connect: {
    endpoints: [
      "tcp/roscon.zenoh.io:7447"
    ],
  },
```

### Run

Now you can run the following commands in your container:
- `ZENOH_ROUTER_CONFIG_URI=/ros_ws/zenoh_confs/ROUTER_CONFIG.json5 ros2 run rmw_zenoh_cpp rmw_zenohd`
- `ros2 topic pub /chatter std_msgs/msg/String "data: Hello from <YOUR_NAME>"` - (replacing `<YOUR_NAME>`)
- `ros2 topic echo /chatter`

### Bonus

Experiment using different `ROS_DOMAIN_ID` for each attendee (for example setting: `export ROS_DOMAIN_ID=42`).  
What happens and why ?

<details>
<summary>Response</summary>

Zenoh has no concept of Domain such as DDS. However, `rmw_zenoh` integrates the `ROS_DOMAIN_ID` in the mapping from topic/service names to zenoh key expressions. Hence, a publisher and a subscriber using the same topic name but on different domains won't communicate with each other, even if interconnected via Zenoh.

</details>

---
[Next exercise ➡️](ex-4.md)