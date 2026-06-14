-- Enable the smooth-scroll snacks module (dashboard + notifier are already
-- on via LazyVim). Pairs with snacks_animate = true for the playful feel.
return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = true },
  },
}
