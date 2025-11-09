#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

## This should install all apps needed to make these configs work
# exec dnf install blueman dunst git grim hyprland kanshi nvim pavucontrol stow tmux waybar wf-recorder wireplumber wofi swaynag
exec dnf install niri nvim tmux


## Make required scripts executable
exec chmod +x $SCRIPT_DIR/dot-config/waybar/scripts/audio_changer.py
## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
exec stow -R --dotfiles -t $HOME $SCRIPT_DIR

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
