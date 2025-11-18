vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Ensure asdf-managed tools (node, npm, etc.) are available in PATH for Neovim
do
  local home = (vim.uv or vim.loop).os_homedir()
  local asdf_paths = { home .. '/.asdf/shims', home .. '/.asdf/bin' }
  local current_path = vim.env.PATH or ''
  for _, p in ipairs(asdf_paths) do
    if not current_path:find(vim.pesc(p), 1, true) then
      current_path = p .. ':' .. current_path
    end
  end
  vim.env.PATH = current_path
end

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
