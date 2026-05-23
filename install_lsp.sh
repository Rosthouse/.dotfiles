#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

sudo -s <<'END_OF_SUDO'
  # Installing runtimes
  dnf install --assumeyes \
    lldb \
    nodejs \
    npm \
  
  # Installing my lsps
  
  ## Bash
  dnf install --assumeyes \
      shellcheck \
      nodejs-bash-language-server \
END_OF_SUDO

## CSharp
dotnet tool install --global csharpier
dotnet tool install --global dotnet-debugger-extensions
dotnet tool install --global dotnet-ef
dotnet tool install --global roslyn-language-server --prerelease

## Python
pip install pyright ruff

## Prettier
npm install -g prettier
