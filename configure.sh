#!/bin/bash

if [[ "$EUID" -ne 0 ]];
  then
  /bin/echo "[*] Please run this script as root"
  exit 1
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No colors
share_folder=/usr/share

program_array=(
	"media-fonts/fontawesome"
	"sys-power/acpi"
	"app-admin/sysstat"
	)

# Check if program is installed, if not install it
for program in ${program_array[@]}; do
	if [[ $(emerge -p $program | grep -i "ebuild  N") ]]
	then
		/bin/echo "[*] $program is not installed, going for installation..." && \
		emerge -q $program && \
		/bin/echo -e "${GREEN}[*] Done ! ${NC}"
	else
		/bin/echo -e "${GREEN}[*] $program is already installed !${NC}"
	fi
done

echo "[?] Please enter the username who will receive the Wayland configuration"
read username
if [[ ! $(/bin/cat /etc/passwd | cut -d ":" -f1 | /bin/grep $username) ]]
then
	/bin/echo -e "${RED}The username provided does not exist ! Exiting...${NC}" && \
	exit 1
fi
username_home_folder=/home/$username
username_id=$(id -u $username)
username_group_id=$(id -g $username)
sway_config_folder=/home/$username/.config/sway

/bin/echo "###########################################"
/bin/echo "[*] Configuring Sway"
if [[ ! -d $sway_config_folder ]]
then
	/bin/mkdir $sway_config_folder && \
	echo -e "${GREEN}[*] $sway_config_folder folder has been created !${NC}"
fi
/bin/cp config $sway_config_folder && \
/bin/cp zsh/zshrc $username_home_folder/.zshrc && \
/bin/cp -r backgrounds $sway_config_folder && \
/bin/cp -r swaybar $sway_config_folder && \
/bin/cp -r bin_scripts $sway_config_folder && \
/bin/cp -r swaybar $sway_config_folder && \
/bin/cp bin_scripts/usb_handler.sh bin_scripts/brightness.sh bin_scripts/convert_to_qcow2.sh /bin && \
/bin/chmod +x /bin/usb_handler.sh /bin/brightness.sh /bin/convert_to_qcow2.sh && \
/bin/chmod 755 -R $sway_config_folder/swaybar/scripts && \
/bin/echo "$username ALL=(ALL) NOPASSWD: /bin/brightness.sh" >> /etc/sudoers && \
/bin/chown $username:$username -R $sway_config_folder && \
/bin/chown $username:$username $username_home_folder/.zshrc && \
/bin/echo -e "${GREEN}[*] Done ! ${NC}"

if [[ ! -d $share_folder/zsh-syntax-highlighting ]]
then
	/usr/bin/sudo /bin/mkdir $share_folder/zsh-syntax-highlighting && \
	/bin/echo -e "${GREEN}[*] $share_folder/zsh-syntax-highlighting folder has been created !${NC}"
fi
/bin/cp zsh/zsh-syntax-highlighting.zsh $share_folder/zsh-syntax-highlighting && \
/bin/cp zsh/highlighters.zip $share_folder/zsh-syntax-highlighting && \
/usr/bin/unzip $share_folder/zsh-syntax-highlighting/highlighters.zip -d $share_folder/zsh-syntax-highlighting && \
/bin/rm $share_folder/zsh-syntax-highlighting/highlighters.zip && \
/usr/bin/touch $share_folder/zsh-syntax-highlighting/.version && \
/usr/bin/touch $share_folder/zsh-syntax-highlighting/.revision-hash && \
/bin/chmod 755 -R /usr/share/zsh-syntax-highlighting && \
/bin/echo -e "${GREEN}[*] Done ! ${NC}"

if [[ ! -d $share_folder/zsh-autosuggestions ]]
then
	/bin/mkdir $share_folder/zsh-autosuggestions
	/bin/echo -e "${GREEN}[*] $share_folder/zsh-autosuggestions folder has been created ! ${NC}"
fi
/bin/cp zsh/zsh-autosuggestions.zsh $share_folder/zsh-autosuggestions && \
/bin/chmod 755 -R /usr/share/zsh-autosuggestions && \
/bin/sed -i "s#$username:x:$username_id:$username_group_id::/home/$username:/bin/bash#$username:x:$username_id:$username_group_id::/home/$username:/bin/zsh#g" /etc/passwd && \
/bin/echo "[*] Done !"
/bin/echo "###########################################"
