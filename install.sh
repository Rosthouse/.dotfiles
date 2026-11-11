#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo -s <<'END_OF_SUDO'
	echo "Enabling external repos"
	dnf --assumeyes copr enable scottames/ghostty

	dnf install --assumeyes --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release ## For Noctalia Shell
  dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo

  ## Add MS Repo for VS Code
  rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

  sudo dnf install tailscale
  # Enable and start tailscaled
  sudo systemctl enable --now tailscaled

	echo "Installing dependencies"
	dnf --assumeyes install \
		ghostty \
		niri \
		noctalia \
		nvim \
		python \
		stow \
		tmux \
    btop \
    code \
    evtest \
    fd-find \
    fzf \
    lazygit \
    noctalia-greeter \
    rclone \
    sesh \
    swappy \
    tailscale \
    tldr \
    ufw \
    v4l2loopback \
    zoxide \

	echo "Installing python libs"
	dnf --assumeyes install \
		pipx \
		python-pip \
		python3-virtualenv

  usermod -a -G input patrick
  systemctl enable --now tailscaled

END_OF_SUDO

## Install python tools
pipx ensurepath

## Make sure required scripts are executable
chmod -R +x "$SCRIPT_DIR/dot-config/userscripts"

## Enabling niri
## systemctl --user add-wants niri.service

## This links all files (not excluded by .stow-local-ignore) to your home directory
## Note that the directory 'dot-config' will map to $HOME/.config/
# echo "Stowing dotfiles"
# cd "$SCRIPT_DIR" || exit
# stow -R --dotfiles -v -t ~ .
# cd - || exit
