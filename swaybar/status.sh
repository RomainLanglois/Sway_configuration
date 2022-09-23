#!/bin/bash

swaybar_script_folder=~/.config/sway/swaybar/scripts
iface=$($swaybar_script_folder/iface)
cpu_usage=$($swaybar_script_folder/cpu_usage)
memory=$($swaybar_script_folder/memory)
volume=$($swaybar_script_folder/volume)
battery=$(acpi -b)
#bandwith=$($swaybar_script_folder/bandwidth)
disk=$($swaybar_script_folder/disk)
#disk-io=$($swaybar_script_folder/disk-io)
brightness=$(/bin/brightness.sh)
time=$(date -u +%H:%M)

echo "enp0s31f6: $iface | CPU: $cpu_usage | RAM: $memory | Volume: $volume | Battery: $battery | Brightness: $brightness | $time"
