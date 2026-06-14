-- Quick-capture from Neovim straight into the Apple world — no intermediary
-- file or app. Shells out to osascript (zero dependencies). First use triggers
-- a one-time macOS Automation permission prompt for your terminal; approve once.
--
-- This is capture *input* to the Apple spine, not a parallel task system.
-- Lives under its own <leader>k ("kapture") prefix to avoid the crowded,
-- LSP-heavy <leader>c (code) group.

-- Where captures land. Change these to retarget.
local REMINDERS_LIST = "🎼 Spine" -- a list in Apple Reminders
local NOTES_FOLDER = "Spine" -- a folder in Apple Notes

local function run_osascript(script, ok_msg, item)
  vim.system({ "osascript", "-e", script }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify(ok_msg .. ": " .. item, vim.log.levels.INFO)
      else
        vim.notify("Capture failed: " .. (obj.stderr or "unknown error"), vim.log.levels.ERROR)
      end
    end)
  end)
end

-- AppleScript string-escape (handles what you'd actually type; not a defense
-- against hostile input — this only ever runs on text you type yourself).
local function esc(s)
  return (s:gsub("\\", "\\\\"):gsub('"', '\\"'))
end

local function capture_reminder()
  vim.ui.input({ prompt = "Reminder → " .. REMINDERS_LIST .. ": " }, function(text)
    if not text or text == "" then
      return
    end
    local script = string.format(
      'tell application "Reminders" to make new reminder at end of list "%s" with properties {name:"%s"}',
      esc(REMINDERS_LIST),
      esc(text)
    )
    run_osascript(script, "Captured to Reminders", text)
  end)
end

local function capture_note()
  vim.ui.input({ prompt = "Note → " .. NOTES_FOLDER .. ": " }, function(text)
    if not text or text == "" then
      return
    end
    local script = string.format(
      'tell application "Notes" to make new note at folder "%s" with properties {name:"%s", body:"%s"}',
      esc(NOTES_FOLDER),
      esc(text),
      esc(text)
    )
    run_osascript(script, "Captured to Notes", text)
  end)
end

return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>k", group = "Kapture (Apple)", icon = " " },
      { "<leader>kr", capture_reminder, desc = "Capture reminder (Apple Reminders)", icon = " " },
      { "<leader>kn", capture_note, desc = "Capture note (Apple Notes)", icon = " " },
    },
  },
}
