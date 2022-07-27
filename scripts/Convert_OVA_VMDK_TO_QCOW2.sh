#!/bin/bash

# TODO
# 	Make the script able to handle multiple vmdk files

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No colors

usage ()
{
	/bin/echo -e "${RED}[*] Wrong parameter passed ! ${NC}"
	/bin/echo "Usage :"
	/bin/echo "	$0 <virtual_disk>"
	/bin/echo "Example: "
	/bin/echo "	$0 kali_linux.ova"
	/bin/echo "	$0 kali_linux.vmdk"
	exit 1
}

virtual_disk=$1
virtual_disk_extension=$(/bin/echo "${virtual_disk##*.}")
virtual_disk_no_extension=$(/usr/bin/basename $virtual_disk .$virtual_disk_extension)

if [[ $virtual_disk && $virtual_disk_extension == "ova" ]]
then
	/bin/echo "[*] OVA file format detected !"
	/bin/echo "[*] Extracting VMDK file from OVA..."
	/bin/tar xvf $virtual_disk
	/bin/echo "[*] Converting VMDK file to QCOW2"
	# This part can't handle multiple vmdk files
	vmdk_file=$(/bin/ls | /bin/grep -i ".vmdk")
	/usr/bin/qemu-img convert -O qcow2 $vmdk_file $virtual_disk_no_extension.qcow2
	/bin/echo "[*] Cleaning current directory"
	/bin/rm $virtual_disk_no_extension.ovf $virtual_disk_no_extension.mf $vmdk_file
	/bin/echo -e "${GREEN}[*] Done ! ${NC}" && \
	exit 0
elif [[ $virtual_disk && $virtual_disk_extension == "vmdk" ]]
then
	/bin/echo "[*] VMDK file format detected !"
	/bin/echo "[*] Converting VMDK file to QCOW2..."
	/usr/bin/qemu-img convert -O qcow2 $virtual_disk $virtual_disk_no_extension.qcow2 && \
	/bin/echo -e "${GREEN}[*] Done ! ${NC}" && \
	exit 0
else
	usage
fi


