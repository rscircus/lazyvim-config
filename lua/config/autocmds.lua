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

-- Spell check: off by default, even for prose. LazyVim's wrap_spell autocmd
-- turns it on for markdown/text/gitcommit/typst — override that back off so
-- the only time spell shows is the brief window after saving (below).
create_augroup("spell_off", { clear = true })
create_autocmd("FileType", {
  desc = "Keep spell check off for prose (override LazyVim's wrap_spell)",
  group = "spell_off",
  pattern = { "markdown", "text", "plaintex", "typst", "gitcommit", "org" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Auto-restore the directory session on startup when nvim is opened with no
-- file arguments — land exactly where you left off, no keystroke. Manual
-- control still available via <leader>qs / <leader>ql / <leader>qd.
create_augroup("auto_restore_session", { clear = true })
create_autocmd("VimEnter", {
  desc = "Restore the session for the current directory on bare startup",
  group = "auto_restore_session",
  nested = true,
  callback = function()
    -- Skip if files were passed, stdin was piped, or we're in a git commit etc.
    if vim.fn.argc() > 0 or vim.g.started_with_stdin then
      return
    end
    if vim.bo.filetype == "gitcommit" or vim.bo.filetype == "gitrebase" then
      return
    end
    local ok, persistence = pcall(require, "persistence")
    if ok then
      persistence.load()
    end
  end,
})
create_autocmd("StdinReadPre", {
  group = "auto_restore_session",
  callback = function()
    vim.g.started_with_stdin = true
  end,
})

-- Enable spell check briefly for prose files after saving
create_augroup("spell_check_on_save", { clear = true })
create_autocmd("BufWritePost", {
  desc = "Enable spell check briefly after saving prose files",
  group = "spell_check_on_save",
  pattern = { "*.md", "*.mdx", "*.txt", "*.org" },
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.wo[win].spell = true
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].spell = false
      end
    end, 5000)
  end,
})
