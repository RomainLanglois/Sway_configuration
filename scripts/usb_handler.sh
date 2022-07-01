#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'

option=$1
device=$2

usage ()
{
	if [ -z "$1" ] || [ -z "$2" ];
	then
		/bin/echo -e "${RED} Bad parameters passed !"
		/bin/echo -e "${RED} Usage: $0 <mount | umount> <device>"
		/bin/echo -e "${RED} Example: $0 mount /dev/sdd1"
		exit 1
	fi
}

mount_usb_key ()
{
	sudo /bin/mkdir /media/device_$1
	sudo /bin/mount /dev/$1 /media/device_$1
	/bin/echo -e "${GREEN} Device mounted"
}

umount_usb_key ()
{
	sudo /bin/umount /media/device_$1 && /bin/sync
	sudo /bin/rm -rf /media/device_$1
	/bin/echo -e "${GREEN} Device demonted"
}

usage $option $device
if [ $option == "mount" ];
then
	mount_usb_key $device
elif [ $option == "umount" ];
then
	umount_usb_key $device
else
	/bin/echo -e "${RED} Only <mount | umount> options are available"
	exit 1
fi
