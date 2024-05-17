set ROS2_LOC $XDG_DATA_HOME/ros2/ros2_humble

if test -d $ROS2_LOC/install
  fish_add_path -pP $ROS2_LOC/install/bin

  if functions -q bass
    bass source $ROS2_LOC/install/setup.bash
  end
end

set -e ROS2_LOC
