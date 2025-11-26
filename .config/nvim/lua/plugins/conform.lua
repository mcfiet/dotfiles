return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.nix = { "alejandra" }
      opts.formatters_by_ft.lua = { "stylua" }

      -- Explicitly configure prettier for JS/TS files
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.javascriptreact = { "prettier" }
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }
      opts.formatters_by_ft.json = { "prettier" }
      opts.formatters_by_ft.css = { "prettier" }

      -- Ensure formatters use system binaries instead of Mason
      opts.formatters = opts.formatters or {}
      opts.formatters.stylua = {
        command = "stylua",
        -- Ensure it uses the system stylua, not Mason's
        prepend_args = {},
      }

      -- Configure prettier to find config from buffer directory
      opts.formatters.prettier = {
        command = "prettier",
        cwd = require("conform.util").root_file({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.js",
          "prettier.config.js",
          "package.json",
        }),
      }
    end,
  },
}
