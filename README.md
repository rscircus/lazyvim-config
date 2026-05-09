# 💤 LazyVim Custom Config

A performance-tuned [LazyVim](https://github.com/LazyVim/LazyVim) configuration with extensive plugin customizations and language support.

## Features

### 🎨 UI Enhancements

- Colorscheme: vim-paper with custom black italicized comments
- Incline: Floating filename statusline with file icons
- Satellite: Additional scrollbar indicators, lazy-loaded after startup
- Transparency: nvim-transparent for terminal background
- Smear Cursor: Smooth cursor animations

### 📝 Language Support

- Python (pyright + ruff)
- Rust
- Markdown (with lazy-loaded code execution via mdeval)
- Git, TOML, and dotfiles

### 🚀 Performance Optimizations

- blink.cmp: Optimized completion with delayed menu/docs and reduced ghost redraws
- Lazy-loaded Quarto/Image/Molten and inactive colorschemes
- Disabled plugins: tint.nvim, yanky.nvim, and unused Clojure/Conjure support
- Update time: 200ms to balance responsiveness and idle CPU
- See [PERFORMANCE_OPTIMIZATIONS.md](PERFORMANCE_OPTIMIZATIONS.md) for details

### 🛠️ Developer Tools

- DAP: Debug Adapter Protocol support
- Neotest: Test runner integration
- GitUI: Terminal git interface
- GV: Git commit browser (`<leader>gV`, current file with `<leader>gv`)
- Git Blame: Virtual text blame info (disabled by default, toggle with `<leader>gu`)
- Navic: LSP location breadcrumbs
- Treesitter Context: Show context at top of screen

### 🎯 Editing Enhancements

- Mini.surround: Surround text with quotes/brackets/tags
- Mini.move: Move lines and selections
- Mini.diff: Inline git diff visualization
- Mini.hipatterns: Highlight hex colors and patterns

### 🧘 Focus Modes

- Zen Mode: Distraction-free coding
- Twilight: Dim inactive code using Treesitter
- No Neck Pain: Center buffer with side margins

### 📄 Special Features

- mdeval: Execute code blocks in markdown files (`<leader>e`)
- Showkeys: Display pressed keys (`:ShowkeysToggle`)
- Prettier: Automatic formatting for web files
- Snacks: Modern picker and file explorer

## 🎮 Key Customizations

### Options

- Line wrap enabled
- Relative numbers disabled
- Diagnostics disabled by default
- WSL clipboard integration
- No window separators (clean look)
- Spell check disabled by default, briefly enabled on prose saves

### File Picker

Using Snacks picker (optimized alternative to Telescope)

## 📦 Installation

Refer to the [LazyVim documentation](https://lazyvim.github.io/installation) for installation instructions.

## ⚡ Performance Notes

This config prioritizes performance:

- Completion delays prevent UI flicker
- LSP timeouts prevent hanging
- Redundant plugins disabled
- See `PERFORMANCE_OPTIMIZATIONS.md` for monitoring with `:Lazy profile`
