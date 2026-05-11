# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim config forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). The upstream `init.lua` is preserved largely as-is; personal customization lives entirely under `lua/custom/`. Primary language focus is Go, with Ruby and Lua support.

Plugin manager is **`vim.pack`** (Neovim's built-in, not lazy.nvim). No lockfile is committed — see `.gitignore`.

## Common commands

- `:lua vim.pack.update()` — fetch plugin updates (`:write` applies, `:quit` cancels)
- `:lua vim.pack.update(nil, { offline = true })` — inspect plugin state without fetching
- `:Mason` — manage LSP servers, formatters, linters, debuggers
- `:checkhealth` — diagnose configuration issues
- `stylua .` — format Lua files (config in `.stylua.toml`: 160 col, 2-space, single quotes, `AutoPreferSingle`)

There is no test suite for this repo.

## Architecture

### Load order

`init.lua` (kickstart, sections 1–9) loads in order, then at the very end:

1. `require 'custom.plugins'` — auto-iterates every `*.lua` in `lua/custom/plugins/` and requires it. No registry list — just drop a file in.
2. `require 'custom'` → loads `custom/options.lua`, `custom/autocmds.lua`, `custom/keymaps.lua`, then `custom/overrides`.
3. `custom/overrides/init.lua` — auto-iterates `*.lua` files in `custom/overrides/`, **sorted alphabetically**, and requires each. These run **after** kickstart and all `custom/plugins/*`, so they can mutate or re-setup any already-loaded plugin.

### `custom/plugins/` vs `custom/overrides/`

- **`custom/plugins/`** — new plugins not in kickstart (snacks, oil, copilot, neotest, smart-splits, vim-test, other.nvim). Each file is self-contained: `vim.pack.add` + `setup` + keymaps.
- **`custom/overrides/`** — extends/reconfigures plugins kickstart already loaded (`blink.cmp`, `conform`, `gitsigns`, `nvim-lspconfig`, `mini.icons`, `nvim-treesitter`). Files run last so they win.

### Critical: setup() merge semantics

Several plugins' `setup()` **replaces** config rather than merging. When overriding, restate kickstart's non-default settings or they'll be lost:

- `blink.cmp.setup()` — full replace. See `custom/overrides/completion.lua` — must restate `fuzzy.implementation = 'lua'` and `signature.enabled = true`.
- `conform.setup()` — merges `formatters_by_ft` but **replaces** `format_on_save` and `default_format_opts`. See `custom/overrides/formatting.lua`.
- `mason-tool-installer.setup{ ensure_installed }` — replaces, not merges. See `custom/overrides/lsp.lua` — combines kickstart's tools (`stylua`, `lua_ls`) with new ones.

### Kickstart base (`init.lua`)

Single-file config organized into commented sections 1–9: foundation/options, vim.pack intro & build hooks, UI plugins (gitsigns, which-key, mini, tokyonight), telescope, LSP (Mason + lspconfig + fidget), conform formatting, blink.cmp + LuaSnip, treesitter, optional kickstart.plugins requires.

`kickstart/plugins/` extras enabled at the bottom of `init.lua`: `debug` (nvim-dap + dap-go), `indent_line`, `lint` (nvim-lint, markdownlint only), `autopairs`. `gitsigns` and `neo-tree` extras are commented out.

### LSP

- Servers configured in kickstart: `lua_ls` (with formatting disabled — stylua handles Lua).
- Servers added in `custom/overrides/lsp.lua`: `gopls` (with inlay hints), `golangci_lint_ls`, `ruby_lsp`.
- All servers are auto-installed via `mason-tool-installer`.
- LSP picker keymaps (`grd`, `grr`, `gri`, `gO`, `gW`, `grt`) are bound twice: kickstart binds them to Telescope; `custom/overrides/lsp.lua` rebinds them to **Snacks picker** in a later `LspAttach` autocmd, so Snacks wins.
- `K` (hover), `<leader>rn` (rename), `<leader>ca` (code action) are added by the custom override.

### Go-specific behavior

- `BufWritePre` autocmd in `custom/overrides/lsp.lua` runs `source.organizeImports` code action before save.
- `custom/overrides/formatting.lua` uses `lsp_format = 'first'` for Go (gopls formats, then conform), `'fallback'` for everything else.
- `custom/overrides/treesitter.lua` installs `go`, `gomod`, `gosum`, `gowork` parsers.
- Debugging: `nvim-dap-go` with delve (see `kickstart/plugins/debug.lua`).
- Testing: `neotest` with `neotest-golang` adapter (see `custom/plugins/go.lua`) **and** `vim-test` (see `custom/plugins/vim_test.lua`, `<leader>tt`/`tn`/`tl`).

### Pickers

Snacks picker replaces Telescope for almost everything in `custom/plugins/snacks.lua` — same `<leader>s*` keymaps, but bound to Snacks. Telescope is still installed/configured by kickstart but largely unused. `vim.ui.select` is routed to Snacks.

### Window navigation

`smart-splits.nvim` (in `custom/plugins/tmux.lua`) binds `<C-h/j/k/l>` for cross-tmux navigation, overriding kickstart's window-move bindings. Oil's default `<C-h>`/`<C-l>` keymaps are disabled to avoid conflicts.

## Conventions

- **Never modify upstream-tracked files unless explicitly asked.** This is a fork of kickstart.nvim and is periodically merged from `upstream/master`. Every line edited in a file owned by upstream (`init.lua`, `lua/custom/plugins/init.lua`, all of `lua/kickstart/`, `.gitignore`, `README.md`) becomes a future merge conflict. Put new behavior in user-owned paths: `lua/custom/{options,autocmds,keymaps}.lua`, `lua/custom/plugins/*.lua`, `lua/custom/overrides/*.lua`. The only currently-accepted divergences in upstream files are: uncommenting the `require 'kickstart.plugins.*'` and `require 'custom.plugins'` lines (intended as user toggles) and the `require 'custom'` bootstrap at the end of `init.lua`.
- Stylua config enforces single quotes and `collapse_simple_statement = "Always"` — short `if x then return end` stays on one line. Don't reformat existing one-liners to multi-line.
- Use `vim.pack.add { 'https://github.com/owner/repo' }` for new plugins in `custom/plugins/`. The `gh()` helper in `init.lua` is local to kickstart's file.
- New filetype-specific behavior: autocmds go in `custom/autocmds.lua`; plugin-specific config in the relevant `custom/plugins/*.lua` or `custom/overrides/*.lua`.
- To extend (not replace) a kickstart-loaded plugin, put it in `custom/overrides/` and remember the merge-semantics caveats above.
