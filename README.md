# Dotfiles / Config Collection

Personal configuration files for macOS tooling. Currently includes:

| Directory | Summary |
| --- | --- |
| `hammerspoon/` | Hyper-key window management, custom `⌥ Tab` app switcher, grid overlay, and quick launcher |
| `nvim/` | Modular Neovim config powered by `lazy.nvim`, featuring Catppuccin theme, Treesitter, LSP, snacks.nvim, and more |

## Hammerspoon Highlights

- **Hyper key:** `⌃⌥⌘⇧`
- **App Switcher:** `⌥ Tab` opens a canvas UI with letters you tap to focus apps
- **Window Snaps:** Hyper + `H/L/J/K` for halves, maximize, center
- **Displays:** Hyper + `,` / `.` move windows between monitors
- **Grid Overlay:** Hyper + `M`
- **Launcher:** Hyper + `A/S/D/F/G/V` launch/focus favorite apps

See [`hammerspoon/README.md`](hammerspoon/README.md) for full details.

## Neovim Highlights

- **Plugin Manager:** [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- **Theme:** Catppuccin (Mocha)
- **Completion:** `blink.cmp` + `LuaSnip`
- **LSP & Treesitter:** `nvim-lspconfig`, `mason.nvim`, `nvim-treesitter`
- **Git tooling:** `gitsigns.nvim`, snacks.nvim git pickers, LazyGit integration
- **Navigation:** `telescope.nvim`, `neo-tree.nvim`, `oil.nvim`
- **Testing / Debugging:** `neotest.nvim`, `nvim-dap`
- **Mini.nvim:** sessions, starter, moves, textobjects, etc.

See [`nvim/README.md`](nvim/README.md) for installation, keymaps, and requirements.

## Getting Started

Clone the repo into the correct config directory, e.g.:

```bash
git clone https://github.com/<you>/<repo>.git ~/.config
```

> ⚠️ Make sure you don’t overwrite configs you care about. Back up first (`mv ~/.config ~/.config.bak`).

After cloning:

1. **Hammerspoon** — open the app, grant Accessibility permissions, click “Reload Config”.
2. **Neovim** — run `nvim`; lazy.nvim will install plugins on first launch.

## Contributing / Customizing

Everything is plain Lua. Update bindings in place, reload, and iterate. PRs / issues welcome if you spot bugs or have improvements.
