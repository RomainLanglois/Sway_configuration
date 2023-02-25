#!/bin/bash

set -e

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # No colors

option=$1
veracrypt_container_full_path=$2
veracrypt_container=${2##*/}
slot_number=1

usage () {
        /bin/echo -e "${RED}[*] Wrong option/parameter passed OR the specified container doesn't exists !${NC}"
        /bin/echo -e "${YELLOW}[*] Usage: "
	/bin/echo -e "	[*] $0 <option> <veracrypt_container>"
	/bin/echo -e "	[*] Only <mount | umount | list> options are available ${NC}"
	exit 1
}

if [[ $option ]]
then
	if [[ "$option" == "mount" && -f "$veracrypt_container_full_path" ]];
	then
		/usr/bin/sudo /bin/mkdir /media/$veracrypt_container && \
		/usr/bin/sudo /bin/chown 1000:1000 /media/$veracrypt_container && \
		/bin/echo -e "${YELLOW}[?] This veracrypt container is locked, please enter the password: ${NC}" && \
		read -s password && \
		until [[ "$slot_number" -ge 64 ]];
		do
			/usr/bin/veracrypt --text --mount $veracrypt_container_full_path /media/$veracrypt_container --password $password --pim 0 --keyfiles "" --protect-hidden no --hash sha512 --slot $slot_number 2> /dev/null && \
			/bin/echo -e "${GREEN}[*] $veracrypt_container has been decrypted and mounted inside /media/$veracrypt_container/${NC}" && \
			break
			slot_number=$((slot_number+1))
		done
	elif [[ "$option" == "umount" && -d "$veracrypt_container_full_path" ]];
	then
		/usr/bin/veracrypt --text --dismount ${veracrypt_container_full_path%/} && \
		/bin/sync && \
		/usr/bin/sudo /bin/rmdir $veracrypt_container_full_path && \
		/bin/echo -e "${GREEN}[*] $veracrypt_container container has been succesfully dismounted${NC}"
	elif [[ "$option" == "list" ]];
	then
		/usr/bin/sudo /usr/bin/veracrypt --text --list
	else
		usage
	fi
else
	usage
fi
