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

### Install all neeeded dependancies
```
sudo apt install xinit xbacklight xinput i3blocks feh redshift alsa-utils acpi fonts-font-awesome conky
```

## Download and use youtube-dl
[Home page](https://ytdl-org.github.io/youtube-dl/download.html)
### Installation commands
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```
### Import the pgp public key (Present on the official webpage)
```
gpg --import XXXXX.asc
```

### Check the package signature
```
sudo wget https://yt-dl.org/downloads/latest/youtube-dl.sig -O youtube-dl.sig
gpg --verify youtube-dl.sig /usr/local/bin/youtube-dl
rm youtube-dl.sig
```

### Download a video and convert it to mp3 format
```
youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s" --yes-playlist 'https://www.youtube.com/watch?v=oVWEb-At8yc'
```

