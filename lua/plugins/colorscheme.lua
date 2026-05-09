return {
  -- Add vim-paper theme
  {
    "yorickpeterse/vim-paper",
    lazy = false,
    priority = 1000, -- Make sure it loads early
    config = function()
      -- Set up custom highlights after the colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "paper",
        callback = function()
          -- Make comments black
          vim.api.nvim_set_hl(0, "Comment", { fg = "#000000", italic = true })
        end,
      })
    end,
  },
  { "shaunsingh/nord.nvim", lazy = true },
  { "kepano/flexoki-neovim", name = "flexoki", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "axgfn/parchment", lazy = true },
  --  { "jayden-chan/base46.nvim" },
  { "navarasu/onedark.nvim", lazy = true, opts = { style = "darker" } },
  { "pineapplegiant/spaceduck", lazy = true },
  { "NLKNguyen/papercolor-theme", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true, opts = { theme = "wave", background = { dark = "wave", light = "lotus" } } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "paper", -- that's vim-paper actually
      --colorscheme = "vim-paper",
      -- colorscheme = "parchment",
      -- colorscheme = "kanagawa",
      -- colorscheme = "parchment",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight-day",
      -- colorscheme = "tokyonight-night",
      --       everforest_enable_italic = true,
      --       everforest_background = "soft",
      --       everforest_better_performance = 1,
    },
  },
  -- {
  --   "b0o/incline.nvim",
  --   config = function()
  --     require("incline").setup()
  --   end,
  --   -- Optional: Lazy load Incline
  --   event = "VeryLazy",
  -- },
}
