return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) ~= "table" then
        return
      end
      opts.ensure_installed =
        vim.tbl_filter(function(lang) return lang ~= "printf" end, opts.ensure_installed)
    end,
  },
}
