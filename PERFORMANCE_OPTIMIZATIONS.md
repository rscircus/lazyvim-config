# Performance Optimizations Applied

## Summary

This config prioritizes lazy-loading and avoids plugins that redraw heavily during normal editing.

## Applied Changes

### Startup Loading

- Lazy-loaded Quarto/Image/Molten stack.
- Lazy-loaded inactive colorschemes.
- Lazy-loaded `mdeval.nvim`, `fidget.nvim`, `satellite.nvim`, and `zen-mode.nvim`.
- Removed stale MiniMap keymap while `mini.map` is disabled.
- Removed unsupported `org` Treesitter ensure entry; `orgmode` provides its own setup.

### UI Performance

- Disabled `tint.nvim`; it can lag with many windows.
- Disabled `yanky.nvim`; it can be heavy on large sessions.
- Kept animations disabled through `vim.g.snacks_animate = false`.

### LSP Cleanup

- Deleted deprecated local LSP handler code that referenced removed `Lspsaga` and `cmp_nvim_lsp` setup.
- Kept the active LSP override that disables slow `marksman` for large markdown files.
- Lazy-load `fidget.nvim` on `LspAttach`.

### Editing Options

- Set `updatetime = 200` to balance responsiveness and idle CPU usage.
- Limited the temporary save-time spell check to prose files and made it window-local.

### Extras Trimmed

- Removed the Clojure LazyVim extra because Conjure was already disabled.

## Validation

Use these after changes:

1. `NVIM_APPNAME=nvim-lazy nvim --headless '+qa'`
2. `:Lazy profile`
3. `:checkhealth`
