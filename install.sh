#!/bin/sh
sudo pacman -Syu --noconfirm
sudo pacman -Sy --noconfirm base-devel git xorg-server xorg-xinit xorg-xrandr libx11 libxft libxinerama ttf-firacode-nerd python-pywal xorg-xrdb xorg-xsetroot 
sudo pacman -Sy --noconfirm zsh exa bat fzf tmux ranger fd ripgrep htop lazygit 

stow src
stow picom
