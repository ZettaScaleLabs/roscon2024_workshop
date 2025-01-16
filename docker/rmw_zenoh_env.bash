# setup ROS environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
# setup rmw_zenoh environment
source /ros_ws/install/setup.bash
export RMW_IMPLEMENTATION=rmw_zenoh_cpp
# set other useful variables
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"
export RCUTILS_COLORIZED_OUTPUT=1
