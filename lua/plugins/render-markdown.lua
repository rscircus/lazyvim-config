-- Inline markdown rendering: headings, tables, checkboxes, code blocks.
-- Renders only the visible range with a debounce, and shows the cursor line
-- raw so editing stays predictable — keeps it perf-friendly.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ft = { "markdown", "quarto" },
  opts = {
    file_types = { "markdown", "quarto" },
  },
}
