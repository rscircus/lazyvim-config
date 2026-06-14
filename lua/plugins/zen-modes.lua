return {
  -- Dim inactive portions of the code while editing using TreeSitter
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },

  {
    "shortcuts/no-neck-pain.nvim",
    event = "VeryLazy",
  },

  -- Typewriter scrolling: keeps the cursor line centered while you write.
  {
    "joshuadanpeterson/typewriter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TWEnable", "TWDisable", "TWToggle", "TWCenter", "TWTop", "TWBottom" },
    keys = {
      { "<leader>uw", "<cmd>TWToggle<cr>", desc = "Toggle typewriter mode" },
    },
    opts = {},
  },
}
