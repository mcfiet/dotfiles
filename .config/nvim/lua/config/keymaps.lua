-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("i", "<C-Del>", "<C-o>dw", { noremap = true }) -- for normal ctrl+delete behaviour

-- Turn off normal-mode macro recording
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })

vim.keymap.set('n', '<ISO_Level3_Shift-j>', '<cmd>m .+1<cr>==gi', { desc = 'Move line down' })
vim.keymap.set('n', '<ISO_Level3_Shift-k>', '<cmd>m .-2<cr>==gi', { desc = 'Move line up' })

-- Map the exact sequences that ISO_Level3_Shift sends
-- The ^H is a literal Ctrl-H character (ASCII 8)
vim.keymap.set("n", "<Char-0x80><Char-0xfc><Char-0x08>j", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<Char-0x80><Char-0xfc><Char-0x08>k", ":m .-2<CR>==", { desc = "Move line up" })

-- For visual mode
vim.keymap.set("v", "<Char-0x80><Char-0xfc><Char-0x08>j", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<Char-0x80><Char-0xfc><Char-0x08>k", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("i", "<Char-0x80><Char-0xfc><Char-0x08>j", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<Char-0x80><Char-0xfc><Char-0x08>k", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
  hop.hint_anywhere({})
end, { remap = true })
vim.keymap.set("", "F", function()
  hop.hint_words({})
end, { remap = true })
vim.keymap.set("", "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- Custom buffer keymaps using Snacks
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers() end, { desc = "Buffers" })
