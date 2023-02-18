#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No colors

option=$1
device=$2
user_id=$(/usr/bin/id -u)
user_group_id=$(/usr/bin/id -g)


if [[ $option ]]
then
	if [[ $option == "mount" && $device ]];
	then
		if [[ $(/usr/bin/sudo /usr/bin/file -sL /dev/$device | /bin/grep -i "LUKS encrypted file") ]];
		then
			/bin/echo "[*] Luks format partition detected !"
			/usr/bin/sudo /sbin/cryptsetup luksOpen /dev/$device decrypted_$device && \
			/usr/bin/sudo /bin/mkdir /media/decrypted_$device && \
			/usr/bin/sudo /bin/mount /dev/mapper/decrypted_$device /media/decrypted_$device && \
			/bin/echo -e "${GREEN}[*] Device mounted ${NC}"
		else
			/usr/bin/sudo /bin/mkdir /media/device_$device && \
			/usr/bin/sudo /bin/mount -o umask=0022,gid=$user_group_id,uid=$user_id /dev/$device /media/device_$device && \
			/bin/echo -e "${GREEN}[*] Device mounted ${NC}"
		fi
	elif [[ $option == "umount" && $device ]];
	then
		if [[ $(/usr/bin/sudo /usr/bin/file -sL /dev/$device | /bin/grep -i "LUKS encrypted file") ]];
		then
			/bin/echo "[*] Luks format partition detected !"
			/usr/bin/sudo /bin/umount /media/decrypted_$device && \
			/usr/bin/sudo /sbin/cryptsetup close /dev/mapper/decrypted_$device && \
			/usr/bin/sudo /bin/rmdir /media/decrypted_$device && \
			/bin/echo -e "${GREEN}[*] You can safely remove the device ${NC}"
		else
			/usr/bin/sudo /bin/sync && \
			/usr/bin/sudo /bin/umount /media/device_$device && \
			/usr/bin/sudo /bin/rmdir /media/device_$device && \
			/bin/echo -e "${GREEN}[*] You can safely remove the device ${NC}"
		fi
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
