#!/bin/bash

# TODO
# Handle multiple veracrypt container at the same time (SLOT number)
# https://arcanecode.com/2021/06/21/veracrypt-on-the-command-line-for-ubuntu-linux/

set -e

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # No colors

option=$1
veracrypt_container=$2

usage_function () {
        /bin/echo -e "${RED}[*] Wrong option or parameter passed !"
        /bin/echo -e "[*] Usage: "
	/bin/echo -e "	[*] $0 <option> <veracrypt_container>"
	/bin/echo -e "	[*] Only <mount | umount | list> options are available ${NC}"
	exit 1
}


if [[ $option ]]
then
	if [[ $option == "mount" && $veracrypt_container ]];
	then
		/usr/bin/sudo /bin/mkdir /media/$veracrypt_container && \
		/usr/bin/sudo /bin/chown 1000:1000 /media/$veracrypt_container && \
		/bin/echo -e "${YELLOW}[?] This veracrypt container is locked, please enter the password: ${NC}" && \
		read -s password && \
		/usr/bin/veracrypt --text --mount $veracrypt_container /media/$veracrypt_container --password $password --pim 0 --keyfiles "" --protect-hidden no --slot 1 && \
		/bin/echo -e "${GREEN}[*] $veracrypt_container has been decrypted and mounted inside /media/$veracrypt_container/${NC}"
	elif [[ $option == "umount" && $veracrypt_container ]];
	then
		/usr/bin/veracrypt --text --dismount /media/$veracrypt_container && \
		/bin/sync && \
		/usr/bin/sudo /bin/rmdir /media/$veracrypt_container && \
		/bin/echo -e "${GREEN}[*] $veracrypt_container container has been succesfully dismounted${NC}"
	elif [[ $option == "list" ]];
	then
		/usr/bin/sudo /usr/bin/veracrypt --text --list
	else
		usage_function
	fi
else
	usage_function
fi
