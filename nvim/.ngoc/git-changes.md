## View current changes to commit (Neovim)

- **Open diff for the repo**
  - `<leader>gg` — Open LazyGit (review staged/unstaged, stage, commit, push)
  - Inside LazyGit: Space = stage, c = commit, Tab = switch panels, q = quit

- **Current file diffs**
  - `<leader>hd` — Diff against index (what’s staged)
  - `<leader>hD` — Diff against last commit (working tree vs HEAD)
  - `<leader>hp` — Preview current hunk inline

- **Navigate changes**
  - `]c` — Next hunk
  - `[c` — Previous hunk

- **Extras**
  - `<leader>hb` — Blame current line
  - (Optional) For file history, use LazyGit’s log view

Plugins involved: `gitsigns.nvim`, `lazygit.nvim`.


### Close LazyGit
- `q` — Quit LazyGit TUI

### Preview all changes before commit
- `<leader>gg` — Open LazyGit to see all changes repo-wide
- Per-file quick check:
  - `<leader>hd` — Current file vs index (staged)
  - `<leader>hD` — Current file vs last commit

## Telescope Projects and hidden files

- **Find Projects**
  - `<leader>fp` — Open Telescope Projects
  - `:Telescope projects` — Command alternative
  - Note: Shows directories you’ve opened before. Open a dot-folder once (e.g., `nvim ~/.config/nvim`) and it will appear next time.

- **Find files including dot-folders**
  - `<leader>ff` — Find files (hidden enabled in this config)
  - `:Telescope find_files hidden=true no_ignore=true` — Force-include hidden and ignored files
