return {
  {
    "saghen/blink.cmp",
    opts = {
      -- Optimize completion trigger
      completion = {
        trigger = {
          -- Only show when typing keywords, not on every character
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = false,
        },
        menu = {
          -- Delay showing menu to reduce UI updates (0ms is too aggressive)
          auto_show_delay_ms = 200,
        },
        documentation = {
          -- Delay showing docs to reduce lag
          auto_show_delay_ms = 300,
          -- Faster updates when docs are shown
          update_delay_ms = 100,
          -- Enable debounce for documentation window
          auto_show = true,
        },
        ghost_text = {
          enabled = false, -- Disable ghost text for better performance
        },
      },
      sources = {
        -- Minimum keyword length before triggering
        min_keyword_length = 2,
      },
      -- Optimize appearance with better performance
      appearance = {
        -- Use nerdfont instead of codicons (lighter)
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
    },
  },
}
