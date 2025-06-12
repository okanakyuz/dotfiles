#!/bin/sh

xrandr --output "$(xrandr | awk '/ connected primary/{print $1; exit}')" --mode 1920x1080
feh --bg-scale ~/.config/wp.jpg
exec dwm
