# Repository Guidelines

## Project Structure & Module Organization
- Root contains README.md for setup and AGENTS.md for contribution rules; dotfiles are meant to be stowed.
- `.config/nvim/` holds the LazyVim-based Neovim config (entrypoint `init.lua`, plugin specs in `lua/plugins`, core settings in `lua/config`, snippets in `snippets/`, format settings in `stylua.toml`, lockfile in `lazy-lock.json`).
- `.config/kitty/` stores terminal settings (`kitty.conf`, `current-theme.conf`).
- `.config/systemd/user/ssh-agent.service` manages the user-level SSH agent.
- `.zshrc` defines shell defaults and Oh My Zsh plugins.

## Build, Test, and Development Commands
- Sync dotfiles using GNU Stow from repo root, e.g. `stow .config/nvim .config/kitty .config/systemd .zshrc`.
- Neovim health check: `nvim --headless "+checkhealth" +qa` (confirms treesitter, LSP, and plugin readiness).
- Update Neovim plugins/parsers: `nvim --headless "+Lazy! sync" "+TSUpdate" +qa`.
- Format Lua config: `stylua .config/nvim` (uses `.config/nvim/stylua.toml`).

## Coding Style & Naming Conventions
- Lua: 2-space indent, 120-column width, spaces over tabs (enforced by Stylua).
- Prefer descriptive snake_case for Lua locals/modules; keep plugin override files small and single-purpose (one plugin per file in `lua/plugins/`).
- Avoid committing machine-specific secrets or tokens; keep per-host overrides outside the repo.

## Testing Guidelines
- No automated tests; rely on fast manual checks:
  - `nvim --headless "+checkhealth" +qa` after plugin or parser changes.
  - Open Neovim once interactively to confirm keymaps and UI pieces (e.g., kitty/nvim colors) still load.
  - For shell changes, start a new shell to verify prompts, completions, and plugin hooks.

## Commit & Pull Request Guidelines
- Use conventional, imperative subjects as seen in history (`feat:`, `update`, etc.); keep scope focused.
- Describe what changed, why, and any manual verification (commands run, platforms tested).
- Link related issues/tasks when available; include screenshots for UI-facing tweaks (kitty themes, Neovim UI).
- Keep commits small and reviewable; avoid reformatting unrelated files.***
