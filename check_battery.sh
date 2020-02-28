#!/bin/bash

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:40:00 ]] ; then
    XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/notify-send "low battery" "$BATTINFO"
fi
