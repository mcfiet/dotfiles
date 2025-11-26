return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    spec = {
      { "<leader>c", group = "+copy" },
      { "<leader>s", group = "+surround help" },
    },
  },

  keys = {
    -- <leader>cp → copy the absolute path of the current file
    {
      "<leader>cp",
      function()
        local path = vim.fn.expand("%:p") -- /full/path/to/file.ext
        vim.fn.setreg("+", path) -- system clipboard
        vim.notify("Copied file path:\n" .. path)
      end,
      desc = "Copy file path",
      mode = "n",
    },

    -- <leader>cP → copy the absolute path of the containing folder
    {
      "<leader>cP",
      function()
        local dir = vim.fn.expand("%:p:h") -- /full/path/to
        vim.fn.setreg("+", dir)
        vim.notify("Copied folder path:\n" .. dir)
      end,
      desc = "Copy folder path",
      mode = "n",
    },

    -- Surround help
    -- extra widget showing custom mappings for mini surround
    {
      "<leader>sh",
      function()
        local help_text = [[
Mini.surround custom mappings:

ADD SURROUND (gsa + char):
  l - console.log()
  d - console.debug()  
  e - console.error()
  j - JSON.stringify()
  F - custom function() (prompts)
  m - markdown code block
  t - HTML tag (prompts)
  f - function call

OTHER SURROUND COMMANDS:
  gsd + char - delete surround
  gsr + old + new - replace surround  
  gsf/gsF + char - find surround
  gsh - highlight surround
  gsn - update n_lines
        ]]
        vim.notify(help_text, vim.log.levels.INFO, { title = "Surround Help" })
      end,
      desc = "Show surround help",
      mode = "n",
    },
  },
}
