#!/usr/bin/env bash
sudo -s <<'END_OF_SUDO'
  # Installing runtimes
  dnf install --assumeyes \
    lldb \
    nodejs \
    npm \
  
  # Installing dnf lsps
  dnf install --assumeyes \
      lua-language-server \
      nodejs-bash-language-server \
      shellcheck \



  ## Prettier
  npm install -g \
    prettier \
    tree-sitter-cli \

END_OF_SUDO

## Treesitter
## git clone https://github.com/tree-sitter/csharp-tree-sitter.git --recursive


## CSharp
dotnet tool install --global csharpier
dotnet tool install --global dotnet-debugger-extensions
dotnet tool install --global dotnet-ef
dotnet tool install --global roslyn-language-server --prerelease

## Python
pip install pyright ruff

## Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
