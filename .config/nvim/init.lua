require("config.lazy")

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0 -- Optional: Verhindert automatisches Öffnen des Quickfix
vim.g.vimtex_compiler_latexmk = {
  options = {
    "-shell-escape",
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.eslint.setup({
  root_dir = function(fname)
    local found_config =
      util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs", "package.json")(fname)

    -- Verhindere Start, wenn keine Konfigurationsdatei
    if not found_config then
      return nil
    end

    -- Verhindere Start, wenn eslint nicht im Projekt installiert
    local eslint_in_node_modules = vim.fn.glob(found_config .. "/node_modules/.bin/eslint")
    if eslint_in_node_modules == "" then
      return nil
    end

    return found_config
  end,
})
