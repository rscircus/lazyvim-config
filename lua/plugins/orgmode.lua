return {
  -- Install and configure nvim-orgmode
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" }, -- Load specifically for org files as well
    config = function()
      -- Setup orgmode
      -- local basepath = "~/Repos/vaults/second_life/second_life/EigenLab/"
      local basepath = "~/orgfiles/"

      require("orgmode").setup({
        -- Update these paths to point to where you want to keep your org files
        org_agenda_files = basepath .. "**/*",
        org_default_notes_file = basepath .. "refile.org", -- <--- FIX IS HERE

        -- Capture Templates
        org_capture_templates = {
          t = {
            description = "TODO Item",
            template = "* TODO %?\n  %u",
            target = basepath .. "todo.org",
          },
          j = {
            description = "Journal Entry",
            template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
            target = basepath .. "journal.org",
          },
          n = {
            description = "Quick Note with Context",
            template = "* %?\n  Context: %a\n  %u",
            target = basepath .. "notes.org",
          },
        },
      })

      -- Register the <leader>o prefix with Which-Key
      -- This stops Neovim from accidentally triggering 'o' (new line)
      local wk_status_ok, wk = pcall(require, "which-key")
      if wk_status_ok then
        wk.add({
          { "<leader>o", group = "Orgmode" },
        })
      end

      -- Optional: Enable experimental LSP support for Neovim 0.11+
      -- (Note: If you are on Neovim 0.10, comment this out to avoid errors)
      vim.lsp.enable("org")
    end,
  },
}
