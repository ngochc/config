return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'disabled', -- Let Oil handle directory buffers
      filtered_items = {
        visible = true, -- Show hidden files by default
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
        },
        never_show = {
          '.git',
          '.DS_Store',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<Tab>'] = 'open_tabnew',
          ['H'] = 'toggle_hidden', -- Toggle hidden files with H
        },
      },
    },
  },
}
