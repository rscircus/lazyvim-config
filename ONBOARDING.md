# Onboarding

A practical tour of what this config actually does for you in daily work. Read [`README.md`](README.md) for the full keymap tables and [`AGENTS.md`](AGENTS.md) for the conventions. This doc is the "why you'd reach for each thing" guide, with a focus on the literate-programming and focus features.

`<leader>` = `Space` · `<localleader>` = `\`. Press `Space` and wait — which-key shows the rest.

---

## Literate programming — run code inside your prose

You write Markdown or Quarto (`.qmd`) documents with fenced code blocks, and execute those blocks in place. Two separate engines are wired up, for two different jobs:

### Quarto + Molten — real Jupyter kernels, output inline

This is the heavy path: a live **Jupyter kernel** running behind your document. Output (text, tables, and **plots/images rendered inline** via image.nvim + kitty) appears right under the cell. No browser, no notebook server UI — the kernel runs, Neovim is the front end.

How the pieces fit:

- **molten-nvim** speaks the Jupyter messaging protocol directly to a kernel (Python, R, Julia, bash…).
- **quarto-nvim** routes each code cell to Molten (`codeRunner.default_method = "molten"`) and gives you LSP + completion *inside* the code blocks via **otter.nvim** (so Python in a `.qmd` gets real Python LSP).
- **image.nvim** draws kernel image output into the buffer.

Workflow in a `.qmd` file:

```
\mi     start the kernel (MoltenInit)   ← do this once per session
\rc     run the cell under the cursor
\ra     run this cell and everything above it
\rA     run all cells
\rl     run the current line
\r      run the visual selection   (visual mode)
\qp     live Quarto preview
\md     stop the kernel (MoltenDeinit)
```

> **Does it integrate with Jupyter? Yes** — Molten attaches to actual Jupyter kernels. It does **not** open the Jupyter web notebook; it *is* the kernel client, in your editor. You can also import/export real `.ipynb` output (`MoltenImportOutput` / `MoltenExportOutput`).

**⚠️ Not functional until you install the Python deps.** As of this writing, none of these are installed — `\mi` will fail without them:

```sh
pip install pynvim jupyter_client jupytext     # required for Molten
python3 -m ipykernel install --user            # register a Python kernel
# then in Neovim: :UpdateRemotePlugins  and restart
```

Inline images additionally need a terminal with the kitty graphics protocol (kitty, WezTerm, Ghostty). `:checkhealth molten` and `:checkhealth image` confirm the setup.

### mdeval — quick one-shot block execution

The light path. In a plain Markdown file, put the cursor in a fenced code block and press `<leader>e`. It runs the block once and writes the result back beneath it. No kernel, no state, no setup beyond the interpreter being on your `PATH`. Use this when you just want to check "does this snippet work" without spinning up Molten.

**Rule of thumb:** scratch snippet → `<leader>e` (mdeval). A document you'll iterate on with shared state and plots → Quarto + Molten.

---

## Focus modes — shrink the world to one thing

Three independent tools, stackable. All exist to cut visual load — the single most useful lever when attention is the scarce resource.

| Command / key | Tool | What it does |
| ------------- | ---- | ------------ |
| `:ZenMode` | zen-mode | Centers the buffer, hides statusline/gutters/tabs. Full distraction-free. Toggle off the same way. |
| (auto, `:Twilight`) | twilight | Dims every paragraph except the one you're editing, using Treesitter. The page literally fades around your cursor. |
| `:NoNeckPain` | no-neck-pain | Adds equal side margins so a single buffer sits centered on a wide monitor instead of stretched edge-to-edge. |

Common combo: `:ZenMode` for deep work on one file; add `:Twilight` if your eye keeps jumping to other functions; `:NoNeckPain` if you just want centered text without hiding the UI.

The whole config leans this way already — diagnostics are **off by default** (no red squiggles nagging mid-thought; turn on per-need), no relative numbers, no window separators, a light low-contrast theme. It's a quiet room by default. (Animations are on, deliberately, for a bit of playfulness — see the fun plugins below.)

For prose specifically: `<leader>uw` toggles **typewriter mode** (cursor line stays centered as you type), and `render-markdown.nvim` renders headings/tables/checkboxes inline so a markdown file reads like the finished thing while you edit it.

---

## Why this setup suits ADHD work

These aren't add-ons — they're the existing features, framed by what they do for executive function.

- **One inline output loop.** Literate programming keeps code, result, and notes on one screen. No alt-tab to a terminal, no context switch to a browser notebook — switching is where the thread gets dropped. Run, see, keep typing.
- **Quiet-by-default UI.** Diagnostics off, no animation, no separators. The editor doesn't compete for attention until you ask it to. Fewer involuntary attention-grabs.
- **`<leader>e` and `\rc` are cheap.** Low activation energy to *do the thing* — the hardest moment for task initiation is the first keystroke. Single-key run beats remembering a CLI invocation.
- **The "cowboy" nudge.** Press `h`/`j`/`k`/`l` (or `+`/`-`) 10+ times in a row and it warns you. A gentle pattern-interrupt against autopilot mashing — pushes you toward deliberate motions (`/search`, counts, jumps) instead of zoning out on held keys. Defined in `lua/config/util.lua`.
- **Capture straight into the Apple spine.** Working memory is unreliable; get it out of your head fast — *into the system you actually use*, not a sidecar. Two keys shell out to `osascript` (no plugin, no intermediary file):
  - `<leader>kr` → reminder into the `🎼 Spine` Reminders list
  - `<leader>kn` → note into the `Spine` Notes folder

  > This feeds the Apple spine directly; it is **not** a second task tracker living in Neovim. That's the whole point — the old orgmode capture made you promote notes by hand, so it's gone. First use pops a one-time macOS permission prompt for your terminal; approve once. Retarget the list/folder via the constants at the top of `lua/plugins/apple-capture.lua`.
- **AI without leaving the buffer.** `<leader>ac` drops Claude Code into a split; it can read context (`<leader>ab` adds the buffer) and propose diffs you accept/reject (`<leader>aa` / `<leader>ad`). Offloads the "where do I even start" stall and the boring mechanical edits.
- **Sessions resume themselves.** Re-establishing context after an interruption is a classic ADHD tax — this config kills it. Open `nvim` in a project with no file argument and it **auto-restores that directory's session** (open buffers, layout, cursor). No keystroke, no "where was I." Manual control is still there: `<leader>qs` restore this dir, `<leader>ql` restore last session, `<leader>qd` don't save this one. (Built on LazyVim's `persistence.nvim`; auto-restore wired in `lua/config/autocmds.lua`.)

### Low-friction additions worth considering (not installed)

Honest gaps, only if a real pain shows up — don't bulk-install:

- **A scratch/persistent terminal toggle** (e.g. Snacks terminal, already available via LazyVim) — one key to a REPL and back, less context loss than a separate window.
- **Pomodoro / timer**: skip it in-editor. You already have Calendar Focus and the physical shop timer; a second timer is a new spine tool (don't). Use the ones you have.

### Playful, by choice

Fun is a feature here, not a distraction — these are lazy-loaded and cost nothing at idle:

- `<leader>ud` hatches a 🦆 that waddles across the buffer (`<leader>uD` cooks it). A pressure valve.
- `<leader>fml` melts your code into falling rain (cellular-automaton) — the sanctioned "tests are broken, I need a second" ritual.
- `<leader>tp` opens **Triforce** coding stats: XP, levels, per-language heatmap. Lean on the XP/heatmap for motivation — it also tracks streaks, but per your own rule (cumulative > consecutive) treat the streak counter as ignorable, not a stick.

Anything new here is a **Layer 3 candidate** — shelve it for a week before committing. Enthusiasm at minute one isn't signal.

---

## First-run checklist

```sh
NVIM_APPNAME=nvim-lazy nvim                     # installs plugins on first launch
# inside nvim:
:checkhealth                                    # surfaces missing binaries
:Lazy                                           # plugin status
```

For the Jupyter/Molten stack specifically, install the Python deps above and run `:checkhealth molten` before expecting `\mi` to work.
