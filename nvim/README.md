# Neovim Configuration

Personal Neovim configuration built around **lazy.nvim** with a focus on fast startup, good defaults, and batteries‑included tooling for day‑to‑day development.

## Highlights

- **Leader key:** `<Space>`
- **Plugin manager:** [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- **Theme:** [`catppuccin`](https://github.com/catppuccin/nvim)
- **UI polish:** `which-key`, `noice`, `mini.statusline`, smooth scrolling & zen mode via `snacks.nvim`
- **Completion & snippets:** [`blink.cmp`](https://github.com/saghen/blink.cmp) + [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip)
- **Language tooling:** `nvim-lspconfig`, `mason.nvim`, `treesitter`
- **Formatting & linting:** [`conform.nvim`](https://github.com/stevearc/conform.nvim) + [`lint.nvim`](https://github.com/mfussenegger/nvim-lint)
- **Git workflow:** `gitsigns.nvim`, `snacks.nvim` git pickers, and [`lazygit.nvim`](https://github.com/kdheepak/lazygit.nvim)
- **Navigation:** `telescope.nvim`, `neo-tree.nvim`, `oil.nvim`, `project.nvim`
- **Testing & debugging:** `neotest.nvim`, `nvim-dap` + helpers
- **Mini collection:** motions, textobjects, commenting, align, split/join, sessions, starter screen, etc.

## Requirements

| Tool | Why |
| --- | --- |
| Neovim 0.9+ | Required runtime |
| Git | Plugin manager uses git |
| ripgrep (`rg`) | Telescope live grep |
| fd (optional) | Faster file search |
| LazyGit (optional) | `<leader>gg` git UI |
| Node / Cargo / Go, etc. | For specific LSP servers |

Install the missing tools with your package manager (Homebrew, apt, etc.).

## Installation

```bash
# backup existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# clone this repo
git clone https://github.com/<your-user>/<your-repo>.git ~/.config/nvim

# open Neovim (lazy.nvim will install plugins on first launch)
nvim
```

## Key Plugins & Keymaps

### Telescope & Navigation
- `<leader>ff` – Find files (shows hidden files)
- `<leader>fg` – Live grep
- `<leader>fb` / `<leader><leader>` – Buffers
- `<leader>fp` – Projects
- `<leader>f/` – Grep open buffers

### File Explorer / Editing
- `\` – Toggle Neo-tree
- `-` – Open current directory in Oil (see oil.lua for more mappings)

### Git
- `<leader>gS` – Snacks git status (changes only)
- `<leader>gB` – Git branches picker
- `<leader>gL` – Git log picker
- `<leader>gD` – Git diff picker
- `<leader>gT` – Git stash picker
- `<leader>gg` – Launch LazyGit
- `<leader>hs` / `<leader>hr` – Stage/reset hunk (gitsigns)
- `<leader>hd` / `<leader>hD` – Diff against index / HEAD

> **Note:** Snacks `git_status` shows "No results" when the working tree is clean.

### LSP & Formatting
- LSP automatically attaches via `mason-lspconfig`
- Hover: `K`
- Code actions: `<leader>ca`
- Format current buffer: `<leader>cf`
- Diagnostics list: `<leader>x` (Trouble) or `<leader>vd`

### Misc
- `<leader>z` – Toggle Snacks zen mode
- `<leader>S` – Mini sessions menu
- `<leader>bd` – Delete buffer (mini.bufremove)

## Displaying Invisible Characters

This config enables list mode by default. To toggle manually inside Neovim:

```vim
:set list          " show tabs, spaces, eol markers
:set list!         " toggle
```

Customize with `:set listchars=tab:→·,trail:·,extends:>,precedes:<,nbsp:␣` if desired.

## Updating Plugins

```bash
cd ~/.config/nvim
nvim --headless \
  +"lua require('lazy').sync()" \
  +qa
```

Or inside Neovim: `:Lazy sync`

## Troubleshooting

- Run `:checkhealth` for missing dependencies
- Use `:Lazy` to inspect plugin state/logs
- If something breaks after updating, remove `~/.local/share/nvim/lazy` and reopen Neovim

## License

MIT – do whatever you want, but attribution is appreciated.
