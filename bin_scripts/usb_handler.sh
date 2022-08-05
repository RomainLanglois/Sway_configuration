#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No colors

option=$1
device=$2

if [[ $option ]]
then
	if [[ $option == "mount" && $device ]];
	then
		/usr/bin/sudo /bin/mkdir /media/device_$device && \
		/usr/bin/sudo /bin/mount /dev/$device /media/device_$device && \
		/bin/echo -e "${GREEN}[*] Device mounted ${NC}"
	elif [[ $option == "umount" && $device ]];
	then
		/usr/bin/sudo /bin/sync && \
		/usr/bin/sudo /bin/umount /media/device_$device && \
		/usr/bin/sudo /bin/rmdir /media/device_$device && \
		/bin/echo -e "${GREEN}[*] You can safely remove the device ${NC}"
	elif [[ $option == "list" ]];
	then
		/usr/bin/sudo /usr/bin/usbguard list-devices
	elif [[ $option == "allow" ]];
	then
		/usr/bin/sudo /usr/bin/usbguard allow-device $device
	elif [[ $option == "block" ]];
	then
		/usr/bin/sudo /usr/bin/usbguard block-device $device
	else
		/bin/echo -e "${RED}[*] Wrong verb or parameter passed !"
		/bin/echo -e "[*] Only <mount | umount | list | allow | block> options are available ${NC}"
		exit 1
	fi
else
        /bin/echo -e "${RED}[*] Usage:"
        /bin/echo -e "  $0 <verb> ${NC}"
fi
