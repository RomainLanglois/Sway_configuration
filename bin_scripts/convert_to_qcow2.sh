#!/bin/bash

set -e

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # No colors

usage ()
{
	/bin/echo -e "${RED}[*] Wrong parameter passed ! ${NC}"
	/bin/echo -e "${YELLOW}Usage :"
	/bin/echo -e "	$0 <virtual_disk>"
	/bin/echo -e "Example: "
	/bin/echo -e "	$0 ./kali_linux.ova"
	/bin/echo -e "	$0 /var/lib/kali_linux.vmdk"
	/bin/echo -e "	$0 /opt/kali_linux.vdi${NC}"
	exit 1
}

virtual_disk=$(/usr/bin/basename "$1")
virtual_disk_extension=${1##*.}
virtual_disk_path=$(/usr/bin/dirname "$1")
virtual_disk_without_extension=$(/usr/bin/basename -s ".$virtual_disk_extension" "$virtual_disk")

if [[ $virtual_disk && $virtual_disk_extension == "ova" ]];
then
	/bin/echo -e "${YELLOW}[!] ova file format detected !"
	/bin/echo -e "[*] Extracting VMDK file from OVA...${NC}" && \
	/bin/tar -xvf "$virtual_disk_path/$virtual_disk" && \
	/bin/echo -e "${YELLOW}[*] Converting VMDK file to QCOW2${NC}" && \
	vmdk_file=$(/usr/bin/find "$virtual_disk_path" -name "*.vmdk") && \
	/usr/bin/qemu-img convert -O qcow2 "$vmdk_file" "${HOME}/KVM_images/$virtual_disk_without_extension.qcow2" && \
	/bin/echo -e "${YELLOW}[*] Cleaning current directory${NC}" && \
	/bin/rm *.ovf *.mf "$vmdk_file" && \
	/bin/echo -e "${GREEN}[*] Done ! ${NC}"
elif [[ $virtual_disk && $virtual_disk_extension == "vmdk" || $virtual_disk && $virtual_disk_extension == "vdi" ]];
then
	/bin/echo -e "${YELLOW}[!] "$virtual_disk_extension" file format detected !"
	/bin/echo -e "[*] Converting "$virtual_disk_extension" file to QCOW2...${NC}" && \
	/usr/bin/qemu-img convert -O qcow2 "$virtual_disk_path/$virtual_disk" "${HOME}/KVM_images/$virtual_disk_without_extension.qcow2" && \
	/bin/echo -e "${GREEN}[*] Done ! ${NC}"
else
	usage
fi
