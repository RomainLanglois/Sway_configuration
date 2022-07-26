#!/bin/bash

# Notes
# Script de configuration de l environnement I3 -> Pas d'installation
# Architecture du dossier i3
# -> scripts
# 	-> usb_handler.sh
#	-> brightness.sh
#	-> Convert_OVA_VMDK_TO_QCOW2.sh
#	-> Autres
# -> backgrounds
#	-> fury.png
# -> zsh
# 	-> zshrc
# 	-> zsh-syntax-highlighting.zsh
#	-> zsh-autosuggestions.zsh
# -> README.md
# -> config
# -> xinitrc
# -> i3blocks
#	-> TODO
# -> configure.sh

# TODO
	# Préparer le répo Gihub i3 config
	# Config i3blocks

i3_config_folder=~/.config/i3/
share_folder=/usr/share
folders_array=(
	"~/.config"
	"~/.config/i3"
	"$share_folder/zsh-syntax-highlighting"
	"$share_folder/zsh-autosuggestions"
)

/bin/echo "###########################################"
/bin/echo "[*] Configuring i3"
for folder in ${folders_array[@]};
do
	if [[ ! -d $folder ]]
	then
		/bin/mkdir $folder || /usr/bin/sudo /bin/mkdir $folder
		echo "[*] $folder has been created !"
	fi
done
/bin/cp xinitrc ~/.xinitrc && \
/bin/cp config $i3_config_folder && \
/bin/cp -r backgrounds $i3_config_folder && \
/bin/cp -r scripts $i3_config_folder && \
/usr/bin/sudo /bin/cp scripts/usb_handler.sh scripts/brightness.sh /bin && \
/usr/bin/sudo /bin/chmod +x /bin/usb_handler.sh /bin/brightness.sh && \
/usr/bin/sudo /bin/echo "$(whoami) ALL=(ALL) NOPASSWD: /bin/brigthtness.sh" >> /etc/sudoers && \
/bin/cp zsh/zshrc ~/.zshrc
/usr/bin/sudo /bin/cp zsh/zsh-syntax-highlighting.zsh share_folder/zsh-syntax-highlighting && \
/usr/bin/sudo /bin/cp zsh/zsh-autosuggestions.zsh $share_folder/zsh-autosuggestions && \
/bin/echo "[*] Done !"
/bin/echo "###########################################"
