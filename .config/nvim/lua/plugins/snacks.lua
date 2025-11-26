return {
  "folke/snacks.nvim",
  opts = {
    notifier = { enabled = true },
    finder = {},
    -- show hidden files in snacks.explorer
    picker = {
      -- projects
      dev = { "~/dev", "~/projects" },
      projects = { "~/obsidian/Basic2" },
      patterns = { ".git", "package.json", "Makefile" },
      recent = true,
      hidden = true,
      ignored = true,
      exclude = {
        ".cache/",
        "node_modules/",
        ".git/",
      },
      sources = {
        explorer = {
          layout = {
            preview = true,
          },
          hidden = true,
          ignored = true,
          exclude = {
            ".cache",
            ".cargo",
            ".gnupg",
            ".ml4w",
            ".local/share/",
          },
        },
        files = {
          hidden = true,
          ignored = false,
          exclude = {
            ".cache",
            ".cargo",
            ".gnupg",
            ".ml4w",
            "*.lock",
            ".DS_Store",
            ".nuget/",
            ".ssh/",
            ".pki/",
            ".var/",
            ".npm/",
            "yay/",

            ".ml4w-hyprland/",
            "dotfiles-bak/",
            "wallpaper/",
            "MultiViewer/",

            -- obsidian
            ".obsidian/",
            "_attachements/",
            "_attachments",
          },
        },
        grep = {
          hidden = true,
          exclude = { "node_modules/", "dist/" },
        },
      },
    },
  },
}
