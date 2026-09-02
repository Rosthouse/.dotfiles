#!/usr/bin/env bash
sudo -s <<'END_OF_SUDO'
  # Installing runtimes
  dnf install --assumeyes \
    gh \
    scons \
    pkgconfig \
    gcc-c++ \
    libstdc++-static \
    wayland-devel \
    golang \
    lldb \
    nodejs \
    npm \

  
  # Installing dnf lsps
  dnf install --assumeyes \
      lua-language-server \
      nodejs-bash-language-server \
      shellcheck \

  ## Install npm language servers
  npm install -g \
    prettier \
    tree-sitter-cli \
    yaml-language-server \

END_OF_SUDO

## Install TMUX tpm
if [ -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

curl -L https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh
. /tmp/dotnet-install.sh
rm dotnet-install.sh

## CSharp
dotnet tool install --global csharpier
dotnet tool install --global dotnet-debugger-extensions
dotnet tool install --global dotnet-ef
dotnet tool install --global roslyn-language-server --prerelease

## Python
pip install pyright ruff

## Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y

cargo install taplo-cli --locked

## XML
if [ -d /opt/xml/lemminx ]; then 
  git clone https://github.com/eclipse-lemminx/lemminx.git
fi

cd /opt/xml/lemminx/
git pull
./mvn clean verify
