-- Lade LSP und null-ls
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- Konfiguration für TexLab (LaTeX LSP)
lspconfig.texlab.setup({
  settings = {
    texlab = {
      auxDirectory = "build",
      bibtexFormatter = "latexindent",
    },
  },
  on_attach = function(client, bufnr)
    -- Definiere Tastenkürzel
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
  end,
})

-- null-ls Konfiguration (Formatierer und Diagnosen)
null_ls.setup({
  sources = {
    -- Formatierer
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.latexindent, -- für LaTeX
    -- Diagnosen
    null_ls.builtins.diagnostics.eslint, -- Beispiel für JavaScript
    null_ls.builtins.diagnostics.flake8, -- Beispiel für Python
  },
  on_attach = function(client, bufnr)
    -- Formatierung bei Speichern
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
