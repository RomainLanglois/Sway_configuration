#!/bin/bash

brightness_file=/sys/class/backlight/intel_backlight/brightness
brightness_value=$(/bin/cat /sys/class/backlight/intel_backlight/brightness)

if [[ $1 == "+" ]]
then
	brightness_value=$(( brightness_value + 100 ))
	/bin/echo $brightness_value | /usr/bin/sudo /usr/bin/tee $brightness_file
elif [[ $1 == "-" ]]
then
	brightness_value=$(( brightness_value - 100 ))
	/bin/echo $brightness_value | /usr/bin/sudo /usr/bin/tee $brightness_file
else
	/bin/echo "[*] Wrong value"
fi
