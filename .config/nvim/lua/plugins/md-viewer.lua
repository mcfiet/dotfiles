return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install", -- Installiert Abhängigkeiten für die Vorschau
    ft = { "markdown" }, -- Lädt das Plugin nur bei Markdown-Dateien
    config = function()
      vim.g.mkdp_auto_start = 1 -- Startet die Vorschau automatisch, wenn du eine Markdown-Datei öffnest
      vim.g.mkdp_open_to_the_world = 1 -- Ermöglicht die Vorschau im Browser
    end,
  },
}
