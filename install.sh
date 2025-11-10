#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

## This should install all apps needed to make these configs work
# exec dnf install blueman dunst git grim hyprland kanshi nvim pavucontrol stow tmux waybar wf-recorder wireplumber wofi swaynag
echo "Installing dependencies"
dnf --assumeyes install niri nvim tmux stow wofi dunst waybar swaybg kanshi wtype wl-clipboard

## Make required scripts executable
chmod +x $SCRIPT_DIR/dot-config/userscripts/*

## Setting up tools

### Setting up TMUX plugins
if [ ! -d $HOME/.tmux/plugins/tpm/ ]; then
  echo "Installing TMUX plugins"
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

### Setting up wofi emoji
if [ ! -f /usr/local/bin/wofi-emoji ]; then
  echo "Installing wofi-emoji"
  git clone https://github.com/Zeioth/wofi-emoji.git /opt/wofi-emoji/
  cd /opt/wofi-emoji/
  git checkout v1.1.0
  ln -s /opt/wofi-emoji/wofi-emoji /usr/local/bin/
  cd -
fi

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
echo "Stowing dotfiles"
cd $SCRIPT_DIR
stow -R --dotfiles -v -t $HOME .
cd -
