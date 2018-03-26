# setupi3

Configuring i3 for ArchLinux

## Usage:

```
git clone https://github.com/RomainLanglois/I3-configuration
```

### Package to install
```
sudo pacman -S i3lock
sudo pacman -S dmenu
sudo pacman -S i3blocks
```

### Configure

The configure file for i3 is located (by default) at:
```
~/.i3/config
```

### Configure i3lock
[Go to this link](https://github.com/meskarune/i3lock-fancy) 

Install dependancies 
```
git clone https://aur.archlinux.org/i3lock-fancy-git.git
tar -zxvf $pkgname.tar.gz
cd $pkgname
makepkg -s
pacman -U $pkgname.tar.xz
```

### Install visual front end for XRandR 
```
sudo pacman -S arandr
```

### Set custom wallpaper

The line for setting custom wallpaper has been added
Before activating that line, you need to install "feh":
```
sudo apt-get install feh
```

### Bind an app to a workspace

firefox is used as an example.

1. Launch firefox, and an empty terminal.
2. In the terminal, run `xprop`, then click the firefox window to
   show the app info. Look for the line "WM_CLASS(STRING)", and
   take a note of the 2nd field, for firefox it's "Firefox".
3. In the config file, add
```
assign [class="Firefox"] $workspace1
```

### Install the icons, theme and apply the system font to GTK applications

1. Install the icons and theme
```
sudo pacman -S arc-gtk-theme
sudo pacman -S arc-icon-gtk
sudo pacman -S elementary-icon-theme 
```

2. Install lxappearance
```
sudo pacman -S lxappearance
```

3. Launch "lxappearance" and choose the installed theme.


### Install the themes and apply the system font to QT applications
1. Install
```
sudo pacman -S qt5-base qt4
sudo pacman -S oxygen oxygen-kde4
```
2. Configure

Modify this file 
```
~/.config/Trolltech.conf
```

Add this at the end 

```
[Qt]
style=Oxygen
```
