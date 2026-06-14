return {
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    cmd = "Neominimap",
    keys = {
      { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Minimap: toggle (global)" },
      { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Minimap: enable (global)" },
      { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Minimap: disable (global)" },
      { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Minimap: refresh" },
      { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>", desc = "Minimap: toggle (window)" },
      { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>", desc = "Minimap: toggle (buffer)" },
      { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Minimap: focus" },
      { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Minimap: unfocus" },
    },
    init = function()
      -- Off by default; opt-in via <leader>nm. Float layout overlays content,
      -- so auto_enable=true makes it feel sticky and hard to dismiss.
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,
        notification_level = vim.log.levels.WARN,
        layout = "float",
        float = {
          minimap_width = 20,
          z_index = 40,
          window_border = "none",
        },
        exclude_filetypes = {
          "help",
          "bigfile",
          "snacks_dashboard",
          "snacks_picker_list",
          "neo-tree",
          "Outline",
          "aerial",
        },
        exclude_buftypes = {
          "nofile",
          "nowrite",
          "quickfix",
          "terminal",
          "prompt",
        },
        search = { enabled = true },
        mark = {
          enabled = true,
          show_builtins = false,
          key = "m",
        },
      }
    end,
  },
}
