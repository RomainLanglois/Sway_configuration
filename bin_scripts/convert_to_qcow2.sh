#!/bin/bash

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
	/bin/echo "	$0 kali_linux.vdi"
	exit 1
}

virtual_disk=$1
virtual_disk_extension=$(/bin/echo "${virtual_disk##*.}")
virtual_disk_no_extension=$(/usr/bin/basename $virtual_disk .$virtual_disk_extension)

if [[ $virtual_disk && $virtual_disk_extension == "ova" ]]
then
	/bin/echo "[*] ova file format detected !"
	/bin/echo "[*] Extracting VMDK file from OVA..." && \
	/bin/tar xvf $virtual_disk && \
	/bin/echo "[*] Converting VMDK file to QCOW2" && \
	vmdk_file=$(/bin/ls *.vmdk) && \
	/usr/bin/qemu-img convert -O qcow2 $vmdk_file $virtual_disk_no_extension.qcow2 && \
	/bin/echo "[*] Cleaning current directory" && \
	/bin/rm $virtual_disk_no_extension.ovf $virtual_disk_no_extension.mf $vmdk_file && \
	/bin/echo -e "${GREEN}[*] Done ! ${NC}"
elif [[ $virtual_disk && $virtual_disk_extension == "vmdk" || $virtual_disk && $virtual_disk_extension == "vdi" ]]
then
	
	/bin/echo "[*] $virtual_disk_extension file format detected !"
	/bin/echo "[*] Converting $virtual_disk_extension file to QCOW2..." && \
	/usr/bin/qemu-img convert -O qcow2 $virtual_disk $virtual_disk_no_extension.qcow2 && \
	/bin/echo -e "${GREEN}[*] Done ! ${NC}"
else
	usage
fi
