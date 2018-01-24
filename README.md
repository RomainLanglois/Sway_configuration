# setupi3

Configuring i3 for ArchLinux

## Usage:

```
git clone https://github.com/RomainLanglois/I3-configuration
``` 

### Configure

The configure file for i3 is located (by default) at:
```
~/.i3/config
```

### Set custom wallpaper

The line for setting custom wallpaper has been added
Before activating that line, you need to install "feh":
```
sudo apt-get install feh
```

### Bound an app to a workspace

A certain app will be launched only in a specified workspace.
Take the "firefox" for example.

1. Launch firefox, and an empty terminal.
2. In the terminal, run `xprop`, then click the firefox window to
   show the app info. Look for the line "WM_CLASS(STRING)", and
   take a note of the 2nd field, for firefox it's "Firefox".
3. In the config file, add
```
assign [class="Firefox"] $workspace1
```

### Apply the system font to GTK applications.

You can easily modify GTK applications font with lxappearance

1. Install lxappearance
```
sudo pacman -S lxappearance
```

### Install GTK theme and icons

1. sudo pacman -S arc-gtk-theme
2. sudo pacman -S arc-icon-gtk
3. sudo pacman -S elementary-icon-theme 
4. Launch "lxappearance" and choose the installed theme.
