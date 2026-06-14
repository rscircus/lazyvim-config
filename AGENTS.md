# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this repo is

A personal [LazyVim](https://github.com/LazyVim/LazyVim) configuration for Neovim, tuned for startup performance and a quiet UI. It is not a plugin or library — it is a user config that gets loaded by `nvim` at runtime.

- Entry point: `init.lua` → `lua/config/lazy.lua` bootstraps `lazy.nvim` and imports `lua/plugins/`.
- LazyVim extras are declared in `lazyvim.json` (do not hand-edit unless you know what you're doing — LazyVim manages it).
- Plugin lockfile: `lazy-lock.json`. Treat as source-controlled state; only commit changes when intentionally bumping plugins.

## Layout

```
init.lua                 # bootstrap only — do not add logic here
lua/config/
  lazy.lua               # lazy.nvim setup
  options.lua            # vim.opt + globals
  keymaps.lua            # custom keymaps
  autocmds.lua           # autocommands
  util.lua               # shared helpers
lua/plugins/             # one file per plugin/group; loaded by lazy.nvim
lua/plugins/lsp/         # LSP server overrides
.neoconf.json            # lua_ls / neodev config for editing this repo
stylua.toml              # formatter config (2-space, 120 col)
lazyvim.json             # LazyVim-managed extras list
```

## Conventions

- **Lua style:** 2-space indent, 120 column width. Run `stylua .` before committing.
- **One concern per plugin file** in `lua/plugins/`. Use the LazyVim spec format (return a table or list of tables).
- **Prefer overriding LazyVim** via `opts = function(_, opts)` rather than replacing the spec wholesale.
- **Lazy-load by default** for anything not critical to startup. Use `event`, `cmd`, `ft`, or `keys` triggers. See `lua/plugins/neominimap.lua`, `lua/plugins/quarto.lua` for examples.
- **No comments that restate the code.** Only add a comment when the _why_ is non-obvious (a workaround, a perf trade-off, a LazyVim quirk).

## Performance is the priority

This config is explicitly tuned. Before adding a plugin or feature, read `PERFORMANCE_OPTIMIZATIONS.md`. Specifically:

- `tint.nvim`, `yanky.nvim`, Clojure/Conjure extras are intentionally disabled — do not re-enable without a reason.
- `vim.g.snacks_animate = false` is intentional.
- `updatetime = 200` is a tuned compromise; don't lower it.
- LSP is overridden to skip `marksman` on large markdown files (`lua/plugins/lsp-overrides.lua`).
- New plugins should be justified against the existing set, not added alongside duplicates.

## Validation

After any change, run at least:

```sh
NVIM_APPNAME=nvim-lazy nvim --headless '+qa'   # config loads cleanly
stylua --check .                                # formatting
```

Interactively, also check:

- `:Lazy profile` — confirm no new plugin loads eagerly without reason
- `:checkhealth` — surface broken setups
- `:Lazy sync` only when intentionally updating

The config lives at `~/.config/nvim-lazy` and is loaded via `NVIM_APPNAME=nvim-lazy`, so it can be tested without disturbing the default `~/.config/nvim`.

## Things to leave alone unless asked

- `lazy-lock.json` — pin file, only changes via `:Lazy update`/`:Lazy sync`.
- `lazyvim.json` — managed by LazyVim's `:LazyExtras` UI.
- The disabled plugin list in `lua/plugins/disable-extras.lua` — each entry is deliberate.
- `init.lua` — should remain a one-liner that requires `config.lazy`.

## Commits

- Style observed in `git log`: short imperative subject, optionally a category prefix (`plugins:`, `readme:`). Keep that style.
- One concern per commit. If you touch a plugin and also reformat, split them.
- Don't commit `.repro/`, `data/`, or anything in `.gitignore`.

## When in doubt

- Look at an existing similar plugin file in `lua/plugins/` and mirror its shape.
- LazyVim docs: <https://lazyvim.github.io>
- lazy.nvim spec: <https://lazy.folke.io/spec>
