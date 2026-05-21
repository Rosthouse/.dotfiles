#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

## Enabling additional copr repos

sudo -s <<'END_OF_SUDO'
	echo "Enabling external repos"
	dnf --assumeyes copr enable scottames/ghostty
	dnf --assumeyes copr enable avengemedia/dms

	dnf install --assumeyes --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release ## For Noctalia Shell

	echo "Installing dependencies"
	dnf --assumeyes install \
		ghostty \
		niri \
		noctalia-shell \
		nvim \
		python \
		stow \
		tmux \
    btop \
    evtest \
    fzf \
    rclone \
    tldr \
    ufw \
    zoxide
	
	echo "Installing python libs"
	dnf --assumeyes install \
		pipx \
		python-pip \
		python3-virtualenv


  sudo usermod -a -G input patrick
END_OF_SUDO


## This should install all apps needed to make these configs work


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

systemctl --user add-wants niri.service dms

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
echo "Stowing dotfiles"
cd $SCRIPT_DIR
stow -R --dotfiles -v -t ~ .
cd -
