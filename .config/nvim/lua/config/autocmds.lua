-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Tab für Bestätigung
    ["<C-e>"] = cmp.mapping.close(), -- Beispiel für Schließen mit Ctrl+e
    ["<CR>"] = cmp.mapping.abort(), -- Deaktiviert Enter für Copilot-Vorschläge
  },
})
