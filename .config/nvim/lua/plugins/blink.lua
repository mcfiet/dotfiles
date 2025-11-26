return {
  "saghen/blink.cmp",
  opts = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {

      -- Use "enter" preset: Enter = accept + fallback
      preset = "enter",

      -- Also accept with Right Arrow
      -- ["<Right>"] = { "accept", "fallback" },
      ["<Tab>"] = { "accept", "fallback" },

      -- Cancel and close cmp with Esc without exiting insert mode
      ["<Esc>"] = { "cancel", "fallback" },
    },
  },
}
