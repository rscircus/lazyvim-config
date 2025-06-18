return {
  -- Add vim-paper theme
  {
    "yorickpeterse/vim-paper",
    lazy = false,
    priority = 1000, -- Make sure it loads early
  },
  { "shaunsingh/nord.nvim" },
  { "kepano/flexoki-neovim", name = "flexoki" },
  { "sainnhe/everforest" },
  { "axgfn/parchment" },
  --  { "jayden-chan/base46.nvim" },
  { "navarasu/onedark.nvim", lazy = false, opts = { style = "darker" } },
  { "pineapplegiant/spaceduck" },
  { "NLKNguyen/papercolor-theme" },
  { "rebelot/kanagawa.nvim", opts = { theme = "wave", background = { dark = "wave", light = "lotus" } } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vim-paper",
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
