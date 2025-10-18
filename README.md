# 💤 LazyVim Custom Config

A performance-tuned [LazyVim](https://github.com/LazyVim/LazyVim) configuration with extensive plugin customizations and language support.

## Features

### 🎨 UI Enhancements

- Colorscheme: vim-paper with custom black italicized comments
- Incline: Floating filename statusline with file icons
- Mini.map: Auto-opening minimap with diagnostic and git integration
- Satellite: Additional scrollbar indicators
- Tint: Dim inactive windows
- Transparency: nvim-transparent for terminal background
- Smear Cursor: Smooth cursor animations

### 📝 Language Support

- Python (pyright + ruff)
- Rust
- Clojure
- Markdown (with code execution via mdeval)
- Git, TOML, and dotfiles

### 🚀 Performance Optimizations

- blink.cmp: Optimized completion with 100ms delay, 300ms LSP timeout
- Disabled plugins: tint.nvim for multi-window performance, vim-move (using mini.move instead)
- LSP timeout: 1000ms to prevent UI blocking
- Update time: 100ms for faster responsiveness
- See [PERFORMANCE_OPTIMIZATIONS.md](PERFORMANCE_OPTIMIZATIONS.md) for details

### 🛠️ Developer Tools

- DAP: Debug Adapter Protocol support
- Neotest: Test runner integration
- GitUI: Terminal git interface
- Git Blame: Virtual text blame info (disabled by default, toggle with `<leader>gu`)
- Aerial: Code outline with LSP symbols
- Navic: LSP location breadcrumbs
- Treesitter Context: Show context at top of screen

### 🎯 Editing Enhancements

- Mini.surround: Surround text with quotes/brackets/tags
- Yanky: Enhanced yank history
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
- Spell check disabled

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
