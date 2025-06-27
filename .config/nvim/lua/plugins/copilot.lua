return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["markdown"] = true,
      ["text"] = true,
      ["html"] = true,
      ["javascript"] = true,
      ["typescript"] = true,
      ["python"] = true,
      ["lua"] = true,
    }
    vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  end,
}
