#
# ~/.bash_profile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

[[ -z $DISPLAY && $(tty) = /dev/tty1 ]] && exec startx
