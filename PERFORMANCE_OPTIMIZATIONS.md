# Performance Optimizations Applied

## Summary

Applied multiple performance optimizations to reduce lag, especially in completion and UI rendering.

## Changes Made

### 1. **Completion Performance (blink.cmp)** - NEW FILE

- **File**: `lua/plugins/blink-performance.lua`
- Added 100ms delay before showing completion menu (was 0ms - too aggressive)
- Reduced documentation auto-show delay to 300ms (was 500ms)
- Disabled ghost text (causes redraws)
- Set minimum keyword length to 2 characters before triggering
- Limited buffer completions to 5 items max
- Optimized LSP timeout to 300ms
- Added provider-specific timeouts

### 2. **Motion Plugins**

- **File**: `lua/plugins/motions.lua`
- Disabled `vim-move` (redundant - using `mini.move` from extras)

### 3. **UI Performance**

- **File**: `lua/plugins/ui.lua`
- Disabled `tint.nvim` - causes lag with multiple windows
- Enabled `performance_mode` for neoscroll.nvim

### 4. **LSP Timeout**

- **File**: `lua/plugins/lsp-overrides.lua`
- Configured `lsp-timeout.nvim` with 1000ms timeout
- Prevents slow LSP servers from blocking UI
- Marksman already disabled (slow in large files)

### 5. **Editor Options**

- **File**: `lua/config/options.lua`
- Reduced `updatetime` from 250ms to 100ms for faster responsiveness

## Plugin Recommendations

### Already Using (Good!)

- ✅ `blink.cmp` - Much faster than nvim-cmp (0.5-4ms vs 60ms debounce)
- ✅ `mini.move` - Lua-based, faster than vim-move
- ✅ `snacks.nvim` - Modern, performant utilities

### Performance Issues Found

- ⚠️ `tint.nvim` - Disabled (causes lag with many windows)
- ⚠️ `vim-move` - Disabled (redundant with mini.move)
- ⚠️ `marksman` LSP - Already disabled (slow in large files)

### Consider Replacing (Future)

- `neoscroll.nvim` - Consider native smooth scroll or mini.animate
- `lspsaga.nvim` - Heavy plugin; LazyVim's native LSP UI is lighter
- `satellite.nvim` + `neominimap.nvim` - Two minimap plugins is redundant

## Testing Instructions

1. Restart Neovim: `:qa` then reopen
2. Run `:Lazy sync` to install/update plugins
3. Test completion lag - should feel more responsive
4. Monitor with `:Lazy profile` to see load times

## Expected Improvements

- ✨ Completion menu appears faster (100ms vs instant flicker)
- ✨ Less CPU usage during typing
- ✨ Smoother scrolling
- ✨ Faster LSP response or timeout instead of hanging
- ✨ Reduced lag with multiple windows open

## Rollback if Needed

If issues arise, you can:

1. Delete `lua/plugins/blink-performance.lua`
2. Re-enable plugins by setting `enabled = true`
3. Revert updatetime to 250ms in options.lua
