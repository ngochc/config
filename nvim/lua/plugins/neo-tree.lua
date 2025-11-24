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
    close_if_last_window = true, -- don't leave Neo-tree as a full-screen window
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
          -- JavaScript/TypeScript
          'node_modules',
          '.next',
          '.nuxt',
          '.cache',
          '.parcel-cache',
          '.turbo',
          'dist',
          'build',
          'coverage',
          '.nyc_output',
          -- Python
          '__pycache__',
          '*.pyc',
          'venv',
          '.venv',
          'env',
          '.env',
          '.pytest_cache',
          '.mypy_cache',
          '.ruff_cache',
          '.tox',
          '.coverage',
          'htmlcov',
          -- Java
          'target',
          '.gradle',
          '.mvn',
          'out',
          '*.class',
          -- Lock files
          'package-lock.json',
          'yarn.lock',
          'pnpm-lock.yaml',
          'poetry.lock',
          'Pipfile.lock',
          'Gemfile.lock',
          'Cargo.lock',
          'composer.lock',
          'go.sum',
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
