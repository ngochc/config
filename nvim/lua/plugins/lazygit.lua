return {
  'kdheepak/lazygit.nvim',
  cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  keys = {
    { '<leader>gg', '<CMD>LazyGit<CR>', desc = '[G]it: Open Lazy[G]it' },
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    vim.g.lazygit_floating_window_use_plenary = 1
  end,
}

