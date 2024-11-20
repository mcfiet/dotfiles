-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
print("Autoformat status: ", vim.g.autoformat_enabled)
require("plugins/vimtex") -- Lädt vimtex für LaTeX
require("plugins.lsp.lsp")
