#!/bin/bash

swaybar_script_folder=~/.config/sway/swaybar/scripts
iface=$($swaybar_script_folder/iface.sh)
cpu=$($swaybar_script_folder/cpu_usage.py)
memory=$($swaybar_script_folder/memory.sh)
volume=$($swaybar_script_folder/volume.sh)
battery=$($swaybar_script_folder/battery.py)
brightness=$($swaybar_script_folder/brightness.sh)
time=$(date -u +%H:%M)

# https://www.getrichordevtryin.com/sway.html#de-jolies-bordures
# echo -e "toto: \uf121"
echo "| $iface | $cpu | $memory | $volume | $battery | $brightness | $time |"
