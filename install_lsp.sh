#!/usr/bin/env bash
sudo -s <<'END_OF_SUDO'
  # Installing runtimes
  dnf install --assumeyes \
    gcc-c++ \
    gh \
    golang \
    libstdc++-static \
    lldb \
    maven \
    nvm \
    pkgconfig \
    scons \
    wayland-devel \
  
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
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else 
  cd ~/.tmux/plugins/tpm
  git pull
  cd -
fi

if ! command -v dotnetup >/dev/null 2>&1; then
  curl -fsSL https://aka.ms/dotnetup/get-dotnetup.sh | bash
  dotnetup init
else
  dotnetup self update
fi

## CSharp
dotnet tool install --global csharpier
dotnet tool install --global dotnet-debugger-extensions
dotnet tool install --global dotnet-ef
dotnet tool install --global roslyn-language-server --prerelease

## Python
pip install pyright ruff

## Rust

if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -y
else
  rustup update
fi

cargo install taplo-cli --locked

## XML
if [ ! -d /opt/xml/lemminx ]; then 
  git clone https://github.com/eclipse-lemminx/lemminx.git /opt/xml/lemminx/
fi

cd /opt/xml/lemminx/
git pull
mvn clean verify
cd -
