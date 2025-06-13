#!/bin/sh


change_wallpaper () 
{
	while true;
	do 	
		wallpaper=$(find ~/.config/wallpapers/ -type f | shuf -n 1)
		feh --bg-scale $wallpaper ;

		wal -i $wallpaper ;


		echo "dwm.normbordercolor:  $(grep 'norm_border' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;
		echo "dwm.normbgcolor:  $(grep 'norm_bg' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;
		echo "dwm.normfgcolor:  $(grep 'norm_fg' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;
		echo "dwm.selbordercolor:  $(grep 'sel_border' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;
		echo "dwm.selbgcolor:  $(grep 'sel_bg' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;
		echo "dwm.selfgcolor:  $(grep 'sel_fg' ~/.cache/wal/colors-wal-dwm.h | awk -F'"' '{print $2}')" >> ~/.cache/wal/colors.Xresources ;

		xrdb -merge ~/.cache/wal/colors.Xresources ;


		sleep 60 ;
	done
}


xrandr --output "$(xrandr | awk '/ connected primary/{print $1; exit}')" --mode 1920x1080

change_wallpaper &
exec dwm
