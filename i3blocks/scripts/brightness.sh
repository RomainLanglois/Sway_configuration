#!/bin/bash

brightness_file=/sys/class/backlight/intel_backlight/brightness
brightness_value=$(/bin/cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(/bin/cat /sys/class/backlight/intel_backlight/max_brightness)

if [[ $1 == "+" ]]
then
	brightness_value=$(($brightness_value + ($max_brightness*10/100)))
	if [[ $brightness_value -ge $max_brightness ]]
	then
		/bin/echo $max_brightness | /usr/bin/sudo /usr/bin/tee $brightness_file
	else
		/bin/echo $brightness_value | /usr/bin/sudo /usr/bin/tee $brightness_file
	fi
elif [[ $1 == "-" ]]
then
	brightness_value=$(($brightness_value - ($max_brightness*10/100)))
	/bin/echo $brightness_value | /usr/bin/sudo /usr/bin/tee $brightness_file
else
	/bin/echo $(($brightness_value*100/852))'%'
fi
