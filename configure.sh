#!/bin/bash

set -e

if [[ "$EUID" -ne 0 ]];
  then
  /bin/echo "[*] Please run this script as root"
  exit 1
fi

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m' # No colors
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
		/bin/echo -e "${YELLOW}[*] $program is not installed, going for installation...${NC}" && \
		emerge -q $program && \
		/bin/echo -e "${GREEN}[*] Done ! ${NC}"
	else
		/bin/echo -e "${GREEN}[*] $program is already installed !${NC}"
	fi
done

/bin/echo -e "${YELLOW}[?] Please enter the username who will receive the Wayland configuration${NC}"
read username
username_home_folder=/home/$username
username_id=$(id -u $username)
username_group_id=$(id -g $username)
sway_config_folder=/home/$username/.config/sway

/bin/echo "###########################################"
/bin/echo -e "${YELLOW}[*] Configuring Sway${NC}"
if [[ ! -d $sway_config_folder ]]
then
	/bin/mkdir $sway_config_folder && \
	echo -e "${GREEN}[*] $sway_config_folder folder has been created !${NC}"
fi
/bin/cp config $sway_config_folder && \
/bin/cp zsh/zshrc $username_home_folder/.zshrc && \
/bin/cp -r backgrounds $sway_config_folder && \
/bin/cp -r bin_scripts $sway_config_folder && \
/bin/cp -r waybar $username_home_folder/.config/ && \
/bin/cp bin_scripts/usb_handler.sh bin_scripts/brightness.sh bin_scripts/convert_to_qcow2.sh bin_scripts/veracrypt_handler.sh /bin && \
/bin/chmod +x /bin/usb_handler.sh /bin/brightness.sh /bin/convert_to_qcow2.sh /bin/veracrypt_handler.sh && \
/bin/echo "$username ALL=(ALL) NOPASSWD: /bin/brightness.sh" >> /etc/sudoers && \
/bin/chown $username:$username -R $sway_config_folder && \
/bin/chown $username:$username $username_home_folder/.zshrc && \
/bin/su - $username -c "/usr/bin/pip3 install --user psutil" && \
/bin/mkdir -p /home/$username/.config/kanshi && \
/usr/bin/wget https://github.com/RomainLanglois/Sway_configuration/kanshi/config -O /home/$username/.config/kanshi/config && \
/bin/echo -e "${GREEN}[*] Done ! ${NC}"

/bin/echo -e "${YELLOW}[*] Configuring ZSH${NC}"
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
/bin/echo -e "${GREEN}[*] Done !${NC}"

/bin/echo -e "${YELLOW}[*] Configuring VIM${NC}"
/bin/mkdir -p $username_home_folder/.vim $username_home_folder/.vim/autoload $username_home_folder/.vim/backup $username_home_folder/.vim/colors $username_home_folder/.vim/plugged && \
/bin/mkdir -p /root/.vim /root/.vim/autoload /root/.vim/backup /root/.vim/colors /root/.vim/plugged && \
/bin/cp vim/vimrc $username_home_folder/.vimrc /root/.vimrc && \
/usr/bin/curl -fLo $username_home_folder/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
/usr/bin/curl -fLo /root/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
/usr/bin/curl -o $username_home_folder/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim && \
/usr/bin/curl -o /root/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim && \
/usr/bin/vim -c 'PlugInstall --sync' -c qa && \ 
/usr/bin/sudo -H -u $username /bin/bash -c "/usr/bin/vim -c 'PlugInstall --sync' -c qa" && \ 
/bin/echo -e "${GREEN}[*] Done !${NC}"
/bin/echo "###########################################"

