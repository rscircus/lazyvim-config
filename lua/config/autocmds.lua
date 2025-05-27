-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- Disable formatting for python for now

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "python" }, false)
set_autoformat({ "toml" }, false)
set_autoformat({ "ini" }, false)

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

create_augroup("file_types", { clear = true })

create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
  desc = "Recognize mdx files as markdown",
  group = "file_types",
  pattern = { "*.mdx" },
  command = [[ set filetype=markdown ]],
})
