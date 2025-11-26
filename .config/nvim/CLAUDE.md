# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Environment Setup

This is a LazyVim Neovim configuration deployed via NixOS home-manager. The configuration is symlinked from `/home/nik/dotfilesOld/.config/nvim` to the NixOS configuration at `/home/nik/nixos-config/home/nik/common/core/default.nix`.

**Critical**: Mason package manager is completely disabled. All LSPs, formatters, and tools are installed system-wide via Nix packages defined in `/home/nik/nixos-config/home/nik/common/core/default.nix:68-81`.

## Common Commands

### Formatting & Linting
- `stylua .` - Format Lua files (system-wide installation)
- `alejandra .` - Format Nix files (system-wide installation)

### Plugin Management
- `:Lazy` - Open Lazy plugin manager
- `:Lazy sync` - Update all plugins
- `:Lazy clean` - Remove unused plugins

### LazyVim Commands
- `:LazyExtras` - Manage LazyVim extras
- `:LazyHealth` - Check health of LazyVim configuration
- `:checkhealth` - General Neovim health check

## Architecture

### Core Structure
- `init.lua` - Entry point that loads `config.lazy`
- `lua/config/` - Core configuration files
  - `lazy.lua` - Lazy.nvim plugin manager setup
  - `options.lua` - Neovim options (scrolloff, spelllang)
  - `keymaps.lua` - Custom keymaps including ISO_Level3_Shift bindings and Hop navigation
  - `autocmds.lua` - Autocommands
- `lua/plugins/` - Plugin configurations that override LazyVim defaults

### Key Plugin Overrides
- `mason-disable.lua` - Completely disables Mason and related plugins
- `nixd.lua` - Configures nixd LSP with alejandra formatter
- `conform.lua` - Overrides formatters to use system binaries (stylua, alejandra)
- `yazi.lua` - File manager integration with custom keymaps
- `hop.nvim` - Motion plugin that overrides default f/F/t/T keys

### Custom Keymaps
- `f` - Hop anywhere (replaces default find)
- `F` - Hop words
- `t`/`T` - Hop char with direction (current line)
- `<leader>-` - Open Yazi file manager
- `<ISO_Level3_Shift-j/k>` - Move lines up/down (AltGr keyboard support)
- `q` - Disabled (macro recording turned off)

### LazyVim Extras Enabled
Per `lazyvim.json`, these extras are active:
- AI: copilot
- Coding: yanky (clipboard management)
- Languages: docker, git, json, kotlin, markdown, sql, tailwind, toml, typescript, yaml
- Utils: dot (dotfile syntax)

### System Dependencies
All tools are managed via Nix in `/home/nik/nixos-config/home/nik/common/core/default.nix`:
- LSPs: nixd, lua-language-server, gopls, typescript-language-server, tailwindcss-language-server, etc.
- Formatters: alejandra, stylua, prettier, shfmt
- Linters: hadolint, markdownlint-cli2

### Spell Checking
- Languages: English and German (`spelllang = { "en", "de" }`)
- Note in config mentions potential spell lang warning - suggests running `nvim -u NORC` then `:set spelllang=en,de`

## Important Notes

- **Never suggest Mason installation** - all packages are managed via Nix
- Plugin configurations in `lua/plugins/` override LazyVim defaults
- The `lazy-lock.json` contains exact plugin versions for reproducibility
- System uses Nerd Font icons (prefer `nf-md-` icons when needed)
- Configuration is version-controlled and deployed via NixOS home-manager symlink