return {
  -- floating statusline
  {
    "b0o/incline.nvim",
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            guibg = "#44406e",
          }
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },

  {
    "xiyaowong/nvim-transparent",
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      },
    },
  },

  -- Tint inactive windows (disabled for performance)
  {
    "levouh/tint.nvim",
    enabled = true, -- TODO: Can cause lag with many windows
  },

  -- Expand window width with animation
  -- TODO: creates problems with Aerial - expands it
  --  {
  --    "anuvyklack/windows.nvim",
  --    event = "VeryLazy",
  --    dependencies = {
  --      "anuvyklack/middleclass",
  --      "anuvyklack/animation.nvim",
  --    },
  --    config = function()
  --      vim.o.winwidth = 10
  --      vim.o.winminwidth = 10
  --      vim.o.equalalways = false
  --      require("windows").setup()
  --    end,
  --  },

  -- Notification manager
  --  {
  --    "rcarriga/nvim-notify",
  --    event = "VeryLazy",
  --    opts = function(_, opts)
  --      opts.background_colour = "#000000" -- 100% transparency
  --    end,
  --  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        component_separators = "",
        section_separators = "",
      },
      --     sections = {
      --       lualine_a = {
      --         {
      --           "mode",
      --           fmt = function(str)
      --             return ""
      --           end,
      --         },
      --       },
      --       lualine_z = {},
      --     },
    },
  },
}
