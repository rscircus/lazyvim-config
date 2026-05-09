-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- --
local opt = vim.opt

-- some defaults, I like
vim.diagnostic.enable(false)

opt.relativenumber = false

opt.wrap = true
-- opt.background = "dark"

-- do not show separators
opt.fillchars = { vert = " ", vertleft = " ", vertright = " ", eob = " ", horiz = " ", horizup = " ", horizdown = " " }

-- Save undo history
opt.undofile = true

--vim.cmd()
opt.clipboard = "unnamedplus"

-- Balance responsiveness with idle CPU usage
opt.updatetime = 200
opt.signcolumn = "yes"
-- TODO: opt.scrolloff = 8

-- Disable spell checking on startup
opt.spell = false

-- WINDOWS special handling
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WSL",
    copy = {
      ["+"] = { "clip.exe" },
      ["*"] = { "clip.exe" },
    },
    paste = {
      ["+"] = {
        "powershell.exe",
        "-noprofile",
        "-c",
        '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      },
      ["*"] = {
        "powershell.exe",
        "-noprofile",
        "-c",
        '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      },
    },
    cache_enabled = false,
  }
end

-- Python
-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.snacks_animate = false
