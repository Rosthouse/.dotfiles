#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

## This should install all apps needed to make these configs work
exec dnf install git hyprland waybar wofi tmux nvim dunst kanshi cliphist blueman stow wireplumber pavucontrol

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
exec stow -R --dotfiles -t $HOME $SCRIPT_DIR
