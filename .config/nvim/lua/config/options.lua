-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.scrolloff = 8
opt.spelllang = { "en", "de" }

-- Smart wrap for markdown files
opt.breakindent = true
opt.breakindentopt = "shift:2,min:40,sbr"
opt.showbreak = "↪ "

-- Disable animations
vim.g.snacks_animate = false

-- Disable automatic root directory changing (keep at cwd/git root)
vim.g.root_spec = { "cwd" }
