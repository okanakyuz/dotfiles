#!/bin/sh


change_wallpaper () 
{
	wallpaper=$(find ~/.config/wallpapers/ -type f | shuf -n 1)
	wal -i $wallpaper ;
	cd ~/src/dwm && make clean && make ;
	cd ~/src/dmenu && make clean && make ;
	cd ~/src/st && make clean && make ;
	
	case ":$PATH:" in 
		*":$HOME/src/dwm"*);;
		*) export PATH="$PATH:$HOME/src/dwm:$HOME/src/dmenu:$HOME/src/st";;
	esac
	cd ~ ;
	
	feh --bg-scale $wallpaper ;
}


xrandr --output "$(xrandr | awk '/ connected primary/{print $1; exit}')" --mode 1920x1080
change_wallpaper 
# picom &
xcompmgr &
 ~/src/dwm-bar/dwm_bar.sh &
exec ~/src/dwm/dwm

