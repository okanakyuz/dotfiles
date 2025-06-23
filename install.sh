#!/bin/sh
sudo pacman -Syu --noconfirm
sudo pacman -Sy --noconfirm base-devel git xorg-server xorg-xinit xorg-xrandr libx11 libxft libxinerama ttf-firacode-nerd python-pywal xorg-xrdb xorg-xsetroot xcompmgr 
sudo pacman -Sy --noconfirm zsh exa bat fzf tmux ranger fd ripgrep htop lazygit unzip go rustup gdb 
sudo pacman -Sy --noconfirm emacs 
sudo pacman -Sy --noconfirm ranger ueberzug python-pygments 
sudo pacman -Sy --noconfirm zsh starship zoxide bat fzf


stow src
stow picom
stow tmux
stow emacs
stow neovim
stow ranger
stow zsh
