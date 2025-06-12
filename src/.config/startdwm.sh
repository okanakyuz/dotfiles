#!/bin/sh

xrandr --output Virtual-1 --mode 1920x1080
feh --bg-scale ~/.config/wp.jpg
exec dwm
