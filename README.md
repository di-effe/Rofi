# General requirements

## Fonts
- Iosevka Nerd Font
  
**Install**

run `./installfonts.sh`


## Icons
- Papirus
  
**Install**
[papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

`Arch Linux`
```
sudo pacman -S papirus-icon-theme
```

`Ubuntu/Debian`
```
sudo apt install papirus-icon-theme
```


# clock.sh
![tags.sh](./screenshots/clock.png)

### Description
Largely derived from [adi1090x's Rofi collection](https://github.com/adi1090x/rofi) it's a simple clock applet.


# launcher.sh
![tags.sh](./screenshots/launcher.png)

### Description
A simple *drun-style* application launcher.



# powermenu.sh
![tags.sh](./screenshots/powermenu.png)

### Description
Largely derived from [adi1090x's Rofi collection](https://github.com/adi1090x/rofi) it's a simple applet to control power actions like Shutdown, Reboot, Lock, Suspend and Logout.

The Lock option requires `/misc/lockscreen` script and
- i3lock
- imagemagick
- scrot
  
It will create a pixelate version of you wallpaper(s) as a background for the lockscreen.

### Config

Change icons in the SETTINGS section.




# tags.sh
![tags.sh](./screenshots/tags.png)

### Description
This script has been designed explicitly for [LeftWM](https://github.com/leftwm/leftwm), so it won´t work with any other WM.

The top section will show the active TAG in the focused screen.
The section below will show any other available TAG to switch to.

Visible or busy can be marked with a special character or icon.

### Config

Each available TAG button will have the width configured in the `WIDTH` var.
Total window width will be calculated using `WIDTH` multiplied for the number of available TAGS (total tags minus the active one).

Busy marker can be set in `ISBUSY`.





