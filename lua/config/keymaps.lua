-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local map = vim.keymap.set
-- --
-- -- UI
-- map("n", "<leader>ut", "<Cmd>set list!<CR>", { desc = "Toggle hidden characters" })

local util = require("config.util")

util.cowboy()

-- Remove key mappings that conflict with macOS
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- Equalize splits
vim.keymap.set("n", "<leader>b=", "<cmd>wincmd =<cr>", { desc = "Balance windows" })

-- Zoom current buffer
vim.keymap.set("n", "<leader>bz", "<cmd>wincmd _<cr>:wincmd |<cr>", { desc = "Zoom buffer" })

-- Sort text in a list
vim.keymap.set("v", "<leader>cs", ":'<,'>sort<cr>", { desc = "Sort selected lines" })

-- Toggle CursorColumn
vim.keymap.set(
  "n",
  "<leader>uo",
  "<cmd>lua require('config.util').toggle_option('cursorcolumn')<cr>",
  { desc = "Toggle CursorColumn" }
)

-- Toggle ColorColumn
vim.keymap.set(
  "n",
  "<leader>uO",
  "<cmd>lua require('config.util').toggle_colorcolumn()<cr>",
  { desc = "Toggle ColorColumn" }
)
