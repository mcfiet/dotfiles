return {
  {
    "nvim-mini/mini.surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        -- Use 'gs' prefix instead of 's' to avoid conflict with search
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },

        -- Custom surroundings for common patterns
        custom_surroundings = {
          -- Console functions
          l = {
            output = { left = "console.log(", right = ")" },
          },
          d = {
            output = { left = "console.debug(", right = ")" },
          },
          e = {
            output = { left = "console.error(", right = ")" },
          },

          -- Print functions
          -- p = {
          --   output = { left = "print(", right = ")" },
          -- },

          -- JSON.stringify
          j = {
            output = { left = "JSON.stringify(", right = ")" },
          },

          -- Custom function with prompt
          F = {
            output = function()
              local func_name = require("mini.surround").user_input("Function name: ")
              if func_name == "" then
                return nil
              end
              return { left = func_name .. "(", right = ")" }
            end,
          },

          -- Markdown code block
          m = {
            output = { left = "\n```\n", right = "\n```" },
          },

          -- -- Spaced variants
          -- ["("] = { output = { left = "( ", right = " )" } },
          -- ["["] = { output = { left = "[ ", right = " ]" } },
          -- ["{"] = { output = { left = "{ ", right = " }" } },
        },
      })
    end,
  },
}
