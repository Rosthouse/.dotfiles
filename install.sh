#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

## Enabling additional copr repos
dnf --assumeyes copr enable scottames/ghostty

## This should install all apps needed to make these configs work
echo "Installing dependencies"
dnf --assumeyes install dunst fuzzel ghostty kanshi niri nvim python python-pip python3-venv pipx stow swaybg tmux waybar wl-clipboard wtype


## Install python tools
pipx ensurepath
pipx install --global pywal16

## Make required scripts executable
chmod +x $SCRIPT_DIR/dot-config/userscripts/*

## Setting up tools

### Setting up TMUX plugins
if [ ! -d $HOME/.tmux/plugins/tpm/ ]; then
  echo "Installing TMUX plugins"
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

## Setting up bemoji
if [ ! -d /opt/bemoji/ ]; then
  echo "Installing bemoji"
  git clone https://github.com/marty-oehme/bemoji.git /opt/bemoji/
  chmod +x /opt/bemoji/bemoji
  ln -s /opt/bemoji/bemoji /usr/local/bin/bemoji
else
  cd /opt/bemoji/
  git pull origin master
fi

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
echo "Stowing dotfiles"
cd $SCRIPT_DIR
stow -R --dotfiles -v -t ~ .
cd -
