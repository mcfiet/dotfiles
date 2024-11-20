return {
  "lervag/vimtex",
  config = function()
    -- PDF Viewer Methode wählen (hier Zathura als Beispiel)
    vim.g.vimtex_view_method = "zathura"
    -- Verwende latexmk für die automatische Kompilierung
    vim.g.vimtex_compiler_method = "latexmk"
  end,
}
