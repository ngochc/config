-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Exit insert mode with jk
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Write/Quit helpers
vim.keymap.set('n', '<leader>w', '<Cmd>write<CR>', { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>q', '<Cmd>quit<CR>', { desc = '[Q]uit window' })
vim.keymap.set('n', '<leader>Q', '<Cmd>quit!<CR>', { desc = '[Q]uit window (force)' })

-- Lazy plugin manager
vim.keymap.set('n', '<leader>l', '<Cmd>Lazy<CR>', { desc = '[L]azy plugin manager' })
vim.keymap.set('n', '<leader>ls', '<Cmd>Lazy sync<CR>', { desc = '[L]azy [S]ync (update plugins)' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank {
      higroup = 'IncSearch', -- Use IncSearch highlight group (more visible)
      timeout = 5000, -- Highlight duration in milliseconds
    }
  end,
})

-- vim: ts=2 sts=2 sw=2 et
