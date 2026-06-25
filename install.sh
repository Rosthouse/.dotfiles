#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo -s <<'END_OF_SUDO'
	echo "Enabling external repos"
	dnf --assumeyes copr enable scottames/ghostty
	dnf --assumeyes copr enable avengemedia/dms
	dnf --assumeyes copr enable buckaroogeek/Tmux_sesh

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
    fd-find \
    fzf \
    lazygit \
    rclone \
    sesh \
    tldr \
    ufw \
    zoxide \


  # Tmux package manager
  curl --remote-name https://github.com/tmuxpack/tpack/releases/download/v1.0.0/tpack_1.0.0_linux_amd64.rpm
  rpm -i tpack_*.rpm
  rm tpack_*.rpm
	
	echo "Installing python libs"
	dnf --assumeyes install \
		pipx \
		python-pip \
		python3-virtualenv


  sudo usermod -a -G input patrick
END_OF_SUDO

## Install python tools
pipx ensurepath

## Make sure required scripts are executable
chmod +x "$SCRIPT_DIR"/dot-config/userscripts/*

## Setting up tools
## Installing tailscale
curl -fsSL https://tailscale.com/install.sh | sh

## Enabling niri
systemctl --user add-wants niri.service dms

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
# echo "Stowing dotfiles"
# cd "$SCRIPT_DIR" || exit
# stow -R --dotfiles -v -t ~ .
# cd - || exit
