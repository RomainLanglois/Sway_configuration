# Setup desktop environnement

Configuring i3 Desktop dor Debian

## Usage:

```
git clone https://github.com/RomainLanglois/I3-configuration
```

### Configure

The configuration file for i3 is located (by default) at:
```
~/.i3/config
```

### Install visual front end for XRandR 
```
sudo apt install arandr
```

### Polybar installation process
#### Esssentials links
[Polybar Github](https://github.com/polybar/polybar)
[Polybar documentation](https://github.com/polybar/polybar/wiki)

#### Dependancies installation process
```
sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
```
```
sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
```

#### Installation commands
```
mkdir build
cd build
cmake ..
make -j$(nproc)
```
Friendly copy and paste
```
mkdir build && cd build && cmake .. && make -j$(nproc)
```

#### Add a symbolic link
```
ln -s polybar /usr/bin/polybar 
```

#### Create the config file
```
install -Dm644 /usr/local/share/doc/polybar/config $HOME/.config/polybar/config
```

#### Check if polybar works
```
polybar example
```

## Install the awesome-font
```
sudo apt install fonts-font-awesome
```

## ToDO List
- Modify the calendar script in the polybar config file
    - Remove the calendar_config file