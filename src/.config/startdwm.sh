#!/bin/sh


change_wallpaper () 
{
	while true;
	do 	
		wallpaper=$(find ~/.config/wallpapers/ -type f | shuf -n 1)
		feh --bg-scale $wallpaper ;
		sleep 60 ;
	done
}


xrandr --output "$(xrandr | awk '/ connected primary/{print $1; exit}')" --mode 1920x1080

change_wallpaper &
exec dwm
