return {
  -- Disable vim-move, use mini.move instead (already in extras)
  {
    "matze/vim-move",
    enabled = false,
  },

  -- replace existing text with contents from a register
  {
    "vim-scripts/ReplaceWithRegister",
    event = "VeryLazy",
  },

  -- w,e,b motions considering camelCase, snake_case and kebab-case as punctuation
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
  },
}
