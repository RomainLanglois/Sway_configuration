#!/bin/bash

if [ $# -eq 0 ]
then
    	echo "No arguments supplied"
        exit 1
fi

filename=$(basename $1)
filename_extension=$(echo "${filename##*.}")
filename_no_extension=${filename%.*}

if [ $filename_extension == "ova" ]
then
	echo "Extracting vmdk file from OVA..."
	tar xvf $filename
	echo "Converting vmdk file to qcow2"
	vmdk_file=$(find . -name "Kali-Linux-2021.4a-virtualbox-amd64*.vmdk")
	qemu-img convert -O qcow2 $vmdk_file $filename_no_extension.qcow2
	echo "Cleaning current directory"
	rm $filename_no_extension.ovf $filename_no_extension.mf $vmdk_file
	exit 0
elif [ $filename_extension == "vmdk" ]
then
	qemu-img convert -O qcow2 $filename $filename_no_extension.qcow2
	exit 0
else
	echo "Invalid file format"
	echo "Allowed file format are ova and vmdk"
	exit 1
fi


