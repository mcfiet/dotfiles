return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian-vaults/Basic2",
      },
    },

    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Daily notes configuration
    daily_notes = {
      folder = "00-Daily",
      date_format = "%Y-%m-%d",
      alias_format = "%a, %-d. %B %Y",
      template = "daily.md",
    },

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "wiki",

    -- Optional, customize the default tags to add to new notes.
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
    --
    -- Optional, for templates (see below).
    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart({ "open", url }) -- Mac
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    end,

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- use_advanced_uri = false,

    -- -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    -- open_app_foreground = false,

    -- picker = {
    --   -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    --   name = "telescope.nvim",
    --   -- Optional, configure key mappings for the picker. These are the defaults.
    --   -- Not all pickers support all mappings.
    --   mappings = {
    --     -- Create a new note from your query.
    --     new = "<C-x>",
    --     -- Insert a link to the selected note.
    --     insert_link = "<C-l>",
    --   },
    -- },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- sort_by = "modified",
    -- sort_reversed = true,

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = "current",

    -- Optional, define your own callbacks to customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      post_setup = function(client)
        -- Add custom command to update daily note aliases
        vim.api.nvim_create_user_command("ObsidianUpdateDailyAliases", function()
          local Path = require("plenary.path")
          -- Use the workspace path directly from the configuration
          local vault_path = vim.fn.expand("~/obsidian-vaults/Basic2")
          local daily_folder = Path:new(vault_path) / "00-Daily"

          if not daily_folder:exists() or not daily_folder:is_dir() then
            vim.notify("Daily notes folder not found: " .. tostring(daily_folder))
            return
          end

          local updated = 0
          local files = vim.fn.glob(tostring(daily_folder / "*.md"), false, true)

          for _, file_path in ipairs(files) do
            local file = Path:new(file_path)
            local filename = vim.fn.fnamemodify(file_path, ":t")

            if filename:match("^%d%d%d%d%-%d%d%-%d%d%.md$") then
              local date_str = filename:gsub("%.md$", "")
              local year, month, day = date_str:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")
              if year and month and day then
                local time = os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })
                local new_alias = os.date("%a, %-d. %B %Y", time)

                -- Read and update the note frontmatter directly
                local content = vim.fn.readfile(file_path)
                if content and #content > 0 then
                  local lines = content
                  local frontmatter_start = -1
                  local frontmatter_end = -1

                  -- Find frontmatter boundaries
                  for i, line in ipairs(lines) do
                    if line:match("^---$") then
                      if frontmatter_start == -1 then
                        frontmatter_start = i
                      else
                        frontmatter_end = i
                        break
                      end
                    end
                  end

                  if frontmatter_start > 0 and frontmatter_end > frontmatter_start then
                    -- Check if aliases already exists
                    local aliases_line = -1
                    for i = frontmatter_start + 1, frontmatter_end - 1 do
                      if lines[i]:match("^aliases:") then
                        aliases_line = i
                        break
                      end
                    end

                    if aliases_line > 0 then
                      -- Update existing aliases (replace the next line)
                      if aliases_line + 1 < frontmatter_end then
                        lines[aliases_line + 1] = "  - " .. new_alias
                      else
                        table.insert(lines, aliases_line + 1, "  - " .. new_alias)
                      end
                    else
                      -- Add new aliases before the closing ---
                      table.insert(lines, frontmatter_end, "aliases:")
                      table.insert(lines, frontmatter_end + 1, "  - " .. new_alias)
                    end

                    -- Also update the first heading if it exists
                    for i = frontmatter_end + 1, #lines do
                      local line = lines[i]
                      if line:match("^# ") then
                        lines[i] = "# " .. new_alias
                        break
                      elseif line:match("%S") then
                        -- If we hit non-empty content that's not a heading, stop looking
                        break
                      end
                    end

                    -- Write the updated content back
                    vim.fn.writefile(lines, file_path)
                    updated = updated + 1
                    vim.notify("Updated: " .. filename .. " -> " .. new_alias)
                  else
                    vim.notify("No frontmatter found in: " .. filename)
                  end
                end
              end
            end
          end
          vim.notify("Updated " .. updated .. " daily note aliases")
        end, { desc = "Update daily note aliases to new format" })

        -- Add custom command to aggregate work entries from daily notes
        vim.api.nvim_create_user_command("ObsidianWorkSummary", function(opts)
          local Path = require("plenary.path")
          local vault_path = vim.fn.expand("~/obsidian-vaults/Basic2")
          local daily_folder = Path:new(vault_path) / "00-Daily"

          if not daily_folder:exists() or not daily_folder:is_dir() then
            vim.notify("Daily notes folder not found: " .. tostring(daily_folder), vim.log.levels.ERROR)
            return
          end

          -- Parse days parameter (default 7)
          local days = tonumber(opts.args) or 7
          local now = os.time()
          local cutoff_time = now - (days * 24 * 60 * 60)

          -- Collect all daily note files within the time range
          local files = vim.fn.glob(tostring(daily_folder / "*.md"), false, true)
          local work_entries = {}

          for _, file_path in ipairs(files) do
            local filename = vim.fn.fnamemodify(file_path, ":t")

            -- Only process files matching YYYY-MM-DD.md pattern
            if filename:match("^%d%d%d%d%-%d%d%-%d%d%.md$") then
              local date_str = filename:gsub("%.md$", "")
              local year, month, day = date_str:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")

              if year and month and day then
                local file_time = os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })

                -- Check if file is within the date range
                if file_time >= cutoff_time and file_time <= now then
                  local content = vim.fn.readfile(file_path)
                  if content and #content > 0 then
                    -- Find the Arbeit section
                    local in_arbeit_section = false
                    local arbeit_lines = {}
                    local date_heading = nil

                    for _, line in ipairs(content) do
                      -- Check for the date heading (e.g., "# Wed, 15. October 2025")
                      if line:match("^# ") and not date_heading then
                        date_heading = line:gsub("^# ", "")
                      end

                      -- Start collecting when we hit ## Arbeit
                      if line:match("^## Arbeit") then
                        in_arbeit_section = true
                      elseif line:match("^## ") and in_arbeit_section then
                        -- Stop when we hit the next section
                        break
                      elseif in_arbeit_section and line:match("%S") then
                        -- Collect non-empty lines
                        table.insert(arbeit_lines, line)
                      end
                    end

                    -- Only add if there are work entries
                    if #arbeit_lines > 0 then
                      table.insert(work_entries, {
                        time = file_time,
                        date = date_heading or date_str,
                        lines = arbeit_lines,
                      })
                    end
                  end
                end
              end
            end
          end

          -- Sort entries by date (oldest first)
          table.sort(work_entries, function(a, b)
            return a.time < b.time
          end)

          if #work_entries == 0 then
            vim.notify("No work entries found in the last " .. days .. " days", vim.log.levels.WARN)
            return
          end

          -- Build the summary content
          local summary_lines = {}
          local start_date = os.date("%d.%m.%Y", work_entries[1].time)
          local end_date = os.date("%d.%m.%Y", work_entries[#work_entries].time)

          table.insert(summary_lines, "# Work Summary - " .. start_date .. " to " .. end_date)
          table.insert(summary_lines, "")

          for _, entry in ipairs(work_entries) do
            table.insert(summary_lines, "## " .. entry.date)
            for _, line in ipairs(entry.lines) do
              table.insert(summary_lines, line)
            end
            table.insert(summary_lines, "")
          end

          -- Insert the summary at the current cursor position
          local buf = vim.api.nvim_get_current_buf()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          local row = cursor_pos[1] - 1 -- 0-indexed

          vim.api.nvim_buf_set_lines(buf, row, row, false, summary_lines)
          vim.notify("Inserted work summary for " .. #work_entries .. " days")
        end, {
          nargs = "?",
          desc = "Aggregate work entries from daily notes (default: last 7 days)",
        })
      end,

      -- Runs anytime you enter the buffer for a note.
      enter_note = function(client, note) end,

      -- Runs anytime you leave the buffer for a note.
      leave_note = function(client, note) end,

      -- Runs right before writing the buffer for a note.
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      post_set_workspace = function(client, workspace) end,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    ui = {
      enable = false, -- set to false to disable all additional syntax features
    },

    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- This will be relative to the current note's directory
      img_folder = function()
        -- Get the directory of the current buffer/note
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file and current_file ~= "" then
          local dir = vim.fn.fnamemodify(current_file, ":h")
          return dir .. "/_attachements"
        end
        -- Fallback to vault root _attachements if no current file
        return "_attachements"
      end,
      -- A function that determines the text to insert in the note when pasting an image.
      img_text_func = function(client, path)
        local link_path
        -- Get relative path from current note's directory
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file and current_file ~= "" then
          local current_dir = vim.fn.fnamemodify(current_file, ":h")
          local relative_path = vim.fn.fnamemodify(tostring(path), ":t")
          link_path = "_attachements/" .. relative_path
        else
          link_path = tostring(path)
        end
        local display_name = vim.fn.fnamemodify(link_path, ":t:r")
        return string.format("![%s](%s)", display_name, link_path)
      end,
    },
  },
}
