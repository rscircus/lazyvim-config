return {
  -- 0. The Build Manager (The Fix for Lua 5.4 issues)
  {
    "vhyrro/luarocks.nvim",
    lazy = true,
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" }, -- Explicitly tell it to manage the 'magick' rock
    },
  },

  -- 1. The Image Renderer
  {
    "3rd/image.nvim",
    ft = { "markdown", "quarto", "vimwiki" },
    dependencies = { "luarocks.nvim" }, -- Wait for luarocks to finish first
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
    },
  },

  -- 2. The Execution Engine (Molten)
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    cmd = {
      "MoltenDeinit",
      "MoltenDelete",
      "MoltenEnterOutput",
      "MoltenEvaluateArgument",
      "MoltenEvaluateLine",
      "MoltenEvaluateOperator",
      "MoltenEvaluateVisual",
      "MoltenExportOutput",
      "MoltenGoto",
      "MoltenHideOutput",
      "MoltenImagePopup",
      "MoltenImportOutput",
      "MoltenInfo",
      "MoltenInit",
      "MoltenInterrupt",
      "MoltenLoad",
      "MoltenNext",
      "MoltenOpenInBrowser",
      "MoltenPrev",
      "MoltenReevaluateAll",
      "MoltenReevaluateCell",
      "MoltenRestart",
      "MoltenSave",
      "MoltenShowOutput",
    },
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },

  -- 3. The Quarto Interface
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "quarto",
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
      local runner = require("quarto.runner")
      local map = vim.keymap.set

      -- Safe Keybindings (\)
      map("n", "<localleader>rc", runner.run_cell, { desc = "Run Cell", silent = true })
      map("n", "<localleader>ra", runner.run_above, { desc = "Run Cell & Above", silent = true })
      map("n", "<localleader>rA", runner.run_all, { desc = "Run All Cells", silent = true })
      map("n", "<localleader>rl", runner.run_line, { desc = "Run Line", silent = true })
      map("v", "<localleader>r", runner.run_range, { desc = "Run Visual Range", silent = true })
      map("n", "<localleader>qp", require("quarto").quartoPreview, { desc = "Quarto Preview", silent = true })

      -- Molten Specific
      map("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Molten Init", silent = true })
      map("n", "<localleader>md", ":MoltenDeinit<CR>", { desc = "Molten Deinit", silent = true })
    end,
  },

  -- 4. Fix Aerial for Quarto
  --  {
  --    "stevearc/aerial.nvim",
  --    opts = function(_, opts)
  --      -- Initialize backends table if it doesn't exist
  --      opts.backends = opts.backends or {}
  --
  --      -- Force Aerial to use Treesitter for Quarto/Markdown files
  --      -- This prevents the "error requesting document symbols" message
  --      opts.backends.quarto = { "treesitter", "markdown", "man" }
  --      opts.backends.markdown = { "treesitter", "markdown", "man" }
  --    end,
  --  },

  -- Register Keybindings
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<localleader>r", group = "Run Code (Quarto)", icon = " " },
        { "<localleader>m", group = "Molten (Kernels)", icon = " " },
        { "<localleader>q", group = "Quarto Misc", icon = " " },
      },
    },
  },
}
-- My previous favorite config
-- return {
--   {
--     "quarto-dev/quarto-nvim",
--     dependencies = {
--       "jmbuhr/otter.nvim",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     ft = { "quarto", "markdown" },
--     opts = {
--       lspFeatures = {
--         enabled = true,
--         languages = { "r", "python", "julia", "bash", "html" },
--         diagnostics = {
--           enabled = true,
--           triggers = { "BufWritePost" },
--         },
--         completion = {
--           enabled = true,
--         },
--       },
--       codeRunner = {
--         enabled = true,
--         default_method = "slime",
--       },
--     },
--     config = function(_, opts)
--       require("quarto").setup(opts)
--       local runner = require("quarto.runner")
--
--       -- We use "localleader" (default: \ ) to avoid LazyVim collisions
--       -- Example: Press \rc to run cell
--       local map = vim.keymap.set
--
--       map("n", "<localleader>rc", runner.run_cell, { desc = "Run Cell", silent = true })
--       map("n", "<localleader>ra", runner.run_above, { desc = "Run Cell & Above", silent = true })
--       map("n", "<localleader>rA", runner.run_all, { desc = "Run All Cells", silent = true })
--       map("n", "<localleader>rl", runner.run_line, { desc = "Run Line", silent = true })
--       map("v", "<localleader>r", runner.run_range, { desc = "Run Visual Range", silent = true })
--       map("n", "<localleader>qp", require("quarto").quartoPreview, { desc = "Quarto Preview", silent = true })
--     end,
--   },
--
--   -- Register the "\" key with which-key so the menu appears
--   {
--     "folke/which-key.nvim",
--     opts = {
--       spec = {
--         { "<localleader>r", group = "Run Code (Quarto)", icon = " " },
--         { "<localleader>q", group = "Quarto Misc", icon = " " },
--       },
--     },
--   },
--
--   -- Send code to terminal
--   {
--     "jpalardy/vim-slime",
--     init = function()
--       vim.b.slime_cell_delimiter = "```"
--       vim.g.slime_target = "neovim"
--       -- Ensure localleader is set to backslash (usually default, but good to be safe)
--       vim.g.maplocalleader = "\\"
--     end,
--   },
-- }
