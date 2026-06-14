# 💤 nvim-lazy — a performance-tuned LazyVim config

A personal [LazyVim](https://github.com/LazyVim/LazyVim) setup on **Neovim 0.12**, tuned for fast startup and a quiet UI. Optimized for Python/Rust/TypeScript/PHP work plus a literate-programming stack (Quarto, Molten, mdeval).

> Working in this repo as a human or an AI agent? Read [`AGENTS.md`](AGENTS.md) — it's the source of truth for conventions, validation, and what to leave alone. This README is the onboarding + keymap reference.

## Design philosophy

1. **Performance is the priority.** Lazy-load by default; avoid plugins that redraw during normal editing. Disabled-on-purpose: `tint.nvim`, ghost-text completion, auto-enabled minimap. See [`PERFORMANCE_OPTIMIZATIONS.md`](PERFORMANCE_OPTIMIZATIONS.md). (Snacks animations are deliberately *on* — a chosen exception for playfulness.)
2. **Quiet UI.** Diagnostics off by default, no relative numbers, no window separators, light `vim-paper` theme with black italic comments, spell only briefly on prose save.
3. **Trim, don't accumulate.** A new plugin must be justified against the existing set, not added alongside a duplicate. Decisions are logged in commits and the two perf/AGENTS docs.
4. **Lean on native Neovim.** On 0.12, LazyVim already routes LSP through native `vim.lsp` config and ships default LSP keymaps (`grn`, `gra`, `grr`, `gri`, `]d`/`[d`) — don't re-implement them. Options that match LazyVim/Neovim defaults are not restated.

## Quick start

This config runs side-by-side with your default `~/.config/nvim`:

```sh
git clone <this-repo> ~/.config/nvim-lazy
NVIM_APPNAME=nvim-lazy nvim            # first launch installs plugins
```

Add `alias lvim='NVIM_APPNAME=nvim-lazy nvim'` to your shell to use it without disturbing the default config.

**Validate after changes:**

```sh
NVIM_APPNAME=nvim-lazy nvim --headless '+qa'   # loads clean, no errors
stylua --check .                                # formatting (2-space, 120 col)
```

`<leader>` is `<Space>`; `<localleader>` is `\`. All LazyVim defaults apply on top of the custom keymaps below — press `<Space>` and wait for which-key to discover the rest.

## Keymaps

### AI — Claude Code (`<leader>a`)

Bridges the [Claude Code](https://claude.ai/code) CLI you already run into a Neovim split, with native diff apply. Uses the CLI's own auth — no API keys. Loads on first use.

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>ac`  | Toggle Claude split             |
| `<leader>af`  | Focus Claude                    |
| `<leader>ar`  | Resume last session             |
| `<leader>aC`  | Continue session                |
| `<leader>am`  | Select model                    |
| `<leader>ab`  | Add current buffer to context   |
| `<leader>as`  | Send selection (visual mode)    |
| `<leader>aa`  | Accept proposed diff            |
| `<leader>ad`  | Deny proposed diff              |

### Git

| Keymap        | Action                              |
| ------------- | ----------------------------------- |
| `<leader>gV`  | Git commit browser (GV)             |
| `<leader>gv`  | Git commit browser, current file    |
| `<leader>gu`  | Toggle inline git blame (off by default) |

### Editing & windows

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>b=`  | Balance window sizes            |
| `<leader>bz`  | Zoom current buffer             |
| `<leader>cs`  | Sort selected lines (visual)    |
| `<leader>uo`  | Toggle CursorColumn             |
| `<leader>uO`  | Toggle ColorColumn (81 ↔ off)   |
| `<leader>uw`  | Toggle typewriter mode (centered cursor) |
| `<leader>e`   | Evaluate code block (markdown, mdeval) |

### Capture → Apple (`<leader>k`)

Fires straight into the Apple spine via `osascript` — no intermediary file. First use prompts for a one-time macOS permission grant.

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>kr`  | Capture reminder → `🎼 Spine` (Reminders) |
| `<leader>kn`  | Capture note → `Spine` (Notes)  |

### Sessions

Opening `nvim` in a project with no file argument auto-restores that directory's session. Manual control:

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>qs`  | Restore session (this dir)      |
| `<leader>ql`  | Restore last session            |
| `<leader>qd`  | Don't save the current session  |

### Fun

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>ud` / `<leader>uD` | Hatch 🦆 / cook it |
| `<leader>fml` | Make it rain (cellular-automaton) |
| `<leader>tp`  | Coding stats (Triforce)         |

### Surround (`gz`, not `s`, to avoid leap conflict)

`gza` add · `gzd` delete · `gzr` replace · `gzf`/`gzF` find right/left · `gzh` highlight

### Literate programming (`<localleader>`, in Quarto/markdown)

| Keymap          | Action               |
| --------------- | -------------------- |
| `<localleader>rc` | Run cell           |
| `<localleader>ra` | Run cell & above   |
| `<localleader>rA` | Run all cells      |
| `<localleader>rl` | Run line           |
| `<localleader>r`  | Run visual range   |
| `<localleader>qp` | Quarto preview     |
| `<localleader>mi` / `md` | Molten init / deinit |

### Minimap (Neominimap — off by default)

Toggle on demand; auto-enable is off because the floating layout overlays the buffer.

| Keymap        | Action                          |
| ------------- | ------------------------------- |
| `<leader>nm`  | Toggle (global)                 |
| `<leader>no` / `<leader>nc` | Enable / disable (global) |
| `<leader>nr`  | Refresh                         |
| `<leader>nwt` / `<leader>nbt` | Toggle for window / buffer |
| `<leader>nf` / `<leader>nu` | Focus / unfocus minimap |

**Can't dismiss it?** `<leader>nc` disables globally; if it lingers run `:Neominimap WinDisable` and `:Neominimap BufDisable` (scope is sticky per-window/buffer). To exclude a filetype permanently, add it to `exclude_filetypes` in `lua/plugins/neominimap.lua`. To swap the floating overlay for a dismissable column, set `layout = "split"` there.

## Layout

```
init.lua                 # bootstrap only
lua/config/              # lazy.lua, options.lua, keymaps.lua, autocmds.lua, util.lua
lua/plugins/             # one file per plugin/group, loaded by lazy.nvim
lua/plugins/lsp/         # LSP overrides
```

## Stack

- **Completion:** blink.cmp (delayed menu/docs, ghost text off, 2-char min keyword)
- **Picker/explorer:** Snacks (instead of Telescope)
- **LSP:** native via LazyVim; Python = pyright + ruff; `marksman` skipped on large markdown
- **Editing:** mini.surround / move / diff / hipatterns, nvim-spider, ReplaceWithRegister
- **Dev:** DAP, Neotest, navic, treesitter-context, GitUI, GV, fidget
- **Focus:** Zen Mode, Twilight, No Neck Pain
- **Literate:** Quarto + Molten + image.nvim + otter + mdeval
- **Capture:** Apple Reminders/Notes via osascript (`<leader>kr` / `<leader>kn`)

## Maintenance

- `:Lazy update` on your schedule — `lazy-lock.json` is the reproducibility contract, committed; `:Lazy restore` rolls back.
- `:Lazy profile` — confirm nothing new loads eagerly.
- `:checkhealth` (and `:checkhealth vim.lsp`) after major changes.
