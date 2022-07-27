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
echo "[?] Please enter the username who will receive this XORG configuration"
read username
username_home_folder=/home/$username
i3_config_folder=/home/$username/.config/i3

/bin/echo "###########################################"
/bin/echo "[*] Configuring i3"
if [[ ! -d $i3_config_folder ]]
then
	/bin/mkdir $i3_config_folder && \
	echo -e "${GREEN}[*] $i3_config_folder folder has been created !${NC}"
fi
/bin/cp xinitrc $username_home_folder/.xinitrc && \
/bin/cp config $i3_config_folder && \
/bin/cp zsh/zshrc $username_home_folder/.zshrc && \
/bin/cp -r backgrounds $i3_config_folder && \
/bin/cp -r i3blocks $i3_config_folder && \
/bin/cp -r scripts $i3_config_folder && \
/bin/cp scripts/usb_handler.sh scripts/brightness.sh /bin && \
/bin/chmod +x /bin/usb_handler.sh /bin/brightness.sh && \
/bin/echo "$username ALL=(ALL) NOPASSWD: /bin/brigthtness.sh" >> /etc/sudoers && \
/bin/chown $username:$username -R $i3_config_folder && \
/bin/chown $username:$username $username_home_folder/.xinitrc $username_home_folder/.zshrc && \
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
touch $share_folder/zsh-syntax-highlighting/.version && \
touch $share_folder/zsh-syntax-highlighting/.revision-hash && \
/bin/chmod 755 -R /usr/share/zsh-syntax-highlighting && \
/bin/echo -e "${GREEN}[*] Done ! ${NC}"

if [[ ! -d $share_folder/zsh-autosuggestions ]]
then
	/bin/mkdir $share_folder/zsh-autosuggestions
	/bin/echo -e "${GREEN}[*] $share_folder/zsh-autosuggestions has been created ! ${NC}"
fi
/bin/cp zsh/zsh-autosuggestions.zsh $share_folder/zsh-autosuggestions && \
/bin/chmod 755 -R /usr/share/zsh-autosuggestions && \
/bin/sed -i "s#$username:x:1000:1000::/home/$username:/bin/bash#$username:x:1000:1000::/home/$username:/bin/zsh#g" /etc/passwd && \
/bin/echo "[*] Done !"
/bin/echo "###########################################"

