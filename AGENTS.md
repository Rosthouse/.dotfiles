# AGENTS.md

High-signal guidance for AI agents working in this dotfiles repository.

## Repository structure

This is a **GNU Stow-based dotfiles** repository for Fedora Linux + Neovim + tmux.

- `dot-*` directories map to `~/.*` via stow (e.g., `dot-config/` → `~/.config/`)
- Files excluded from stowing are listed in `.stow-local-ignore`
- **Commented-out stow command** in `install.sh:67-68` — stowing is manual, not automated by the install script
- **To stow changes**: use the `sld` alias (defined in `dot-bashrc.d/bash_aliases.sh:10`) when inside the repo directory

## Neovim plugin management

**Uses `vim.pack` (Neovim 0.11+ native package manager), NOT lazy.nvim.**

- Plugins are declared in `/dot-config/nvim/plugin/*.lua` using `vim.pack.add({ "https://github.com/..." })`
- Lock file: `dot-config/nvim/nvim-pack-lock.json` (tracks revisions)
- Configuration pattern:
  ```lua
  vim.pack.add({ "https://github.com/owner/plugin" })
  require("plugin").setup({ ... })
  ```

**Key dependencies already installed:**
- `mini.nvim` (stable) — includes `mini.icons`, `mini.files`, `mini.statusline`, etc.
- `plenary.nvim`, `telescope.nvim` (already present for octo.nvim and other plugins)
- `gitsigns.nvim`, `nvim-treesitter`, `nvim-lspconfig`, `nvim-dap`

**When adding plugins:**
- Use `mini.icons` (already available) instead of `nvim-web-devicons`
- Add to the appropriate file in `plugin/` (e.g., `plugin/git.lua` for git-related plugins)
- Keep configuration minimal — only override defaults when necessary
- No lazy-loading; plugins load at startup

## Setup scripts

- `install.sh` — system dependencies (Fedora dnf), enables COPR repos, installs ghostty/niri/nvim/tmux/etc.
- `install_lsp.sh` — language servers and tooling (lua-language-server, bash-language-server, prettier, etc.)
- **Both use `sudo -s <<'END_OF_SUDO'` heredoc pattern** for elevated commands

**Commands are not idempotent** — rerunning may reinstall packages but should not break.

## Key conventions

- Bashrc is split into `dot-bashrc.d/*.sh` for modularity
- Keybindings use `<leader>` extensively; gitsigns uses `<leader>gb`, `<leader>gbt`
- LSP config in `plugin/lsp.lua` uses `vim.lsp.enable()` and `vim.lsp.config()` (Neovim 0.11+ API)
- User scripts in `dot-config/userscripts/` must be executable (`chmod +x` in `install.sh:55`)

## Testing changes

No automated tests. Verify manually:
- Neovim: `nvim --headless +quit` (check for errors on startup)
- Stow: `stow -n --dotfiles -v -t ~ .` (dry-run to preview symlinks)
