return {
  {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Search hidden files
            '--no-ignore', -- Ignore .gitignore files
            -- 🚫 Ignore popular dependency / build folders
            '--glob=!.git/', -- Exclude .git directory
            -- JavaScript/TypeScript
            '--glob=!node_modules/',
            '--glob=!.next/',
            '--glob=!.nuxt/',
            '--glob=!.cache/',
            '--glob=!.parcel-cache/',
            '--glob=!.turbo/',
            '--glob=!dist/',
            '--glob=!build/',
            '--glob=!coverage/',
            '--glob=!.nyc_output/',
            '--glob=!*.min.js',
            '--glob=!*.min.css',
            -- Lock files
            '--glob=!package-lock.json',
            '--glob=!yarn.lock',
            '--glob=!pnpm-lock.yaml',
            '--glob=!poetry.lock',
            '--glob=!Pipfile.lock',
            '--glob=!Gemfile.lock',
            '--glob=!Cargo.lock',
            '--glob=!composer.lock',
            '--glob=!go.sum',
            -- Python
            '--glob=!__pycache__/',
            '--glob=!*.pyc',
            '--glob=!*.pyo',
            '--glob=!*.pyd',
            '--glob=!.Python',
            '--glob=!venv/',
            '--glob=!.venv/',
            '--glob=!env/',
            '--glob=!.env/',
            '--glob=!.pytest_cache/',
            '--glob=!.mypy_cache/',
            '--glob=!.ruff_cache/',
            '--glob=!.tox/',
            '--glob=!.coverage',
            '--glob=!htmlcov/',
            -- Java
            '--glob=!target/',
            '--glob=!.gradle/',
            '--glob=!.mvn/',
            '--glob=!build/',
            '--glob=!out/',
            '--glob=!*.class',
            '--glob=!*.jar',
            '--glob=!*.war',
            '--glob=!*.ear',
            -- IDE
            '--glob=!.idea/',
            '--glob=!.vscode/',
            '--glob=!.settings/',
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- Show hidden files
            no_ignore = true, -- Don't respect .gitignore
            no_ignore_parent = true, -- Don't respect parent .gitignore
            -- Use rg with --no-ignore to show all files including those in .gitignore
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--no-ignore',
              -- Exclude .git
              '--glob',
              '!.git/',
              -- JavaScript/TypeScript
              '--glob',
              '!node_modules/',
              '--glob',
              '!.next/',
              '--glob',
              '!.nuxt/',
              '--glob',
              '!.cache/',
              '--glob',
              '!.parcel-cache/',
              '--glob',
              '!.turbo/',
              '--glob',
              '!dist/',
              '--glob',
              '!build/',
              '--glob',
              '!coverage/',
              '--glob',
              '!.nyc_output/',
              -- Lock files
              '--glob',
              '!package-lock.json',
              '--glob',
              '!yarn.lock',
              '--glob',
              '!pnpm-lock.yaml',
              '--glob',
              '!poetry.lock',
              '--glob',
              '!Pipfile.lock',
              '--glob',
              '!Gemfile.lock',
              '--glob',
              '!Cargo.lock',
              '--glob',
              '!composer.lock',
              '--glob',
              '!go.sum',
              -- Python
              '--glob',
              '!__pycache__/',
              '--glob',
              '!*.pyc',
              '--glob',
              '!venv/',
              '--glob',
              '!.venv/',
              '--glob',
              '!env/',
              '--glob',
              '!.pytest_cache/',
              '--glob',
              '!.mypy_cache/',
              '--glob',
              '!.ruff_cache/',
              '--glob',
              '!.tox/',
              -- Java
              '--glob',
              '!target/',
              '--glob',
              '!.gradle/',
              '--glob',
              '!.mvn/',
              '--glob',
              '!out/',
              '--glob',
              '!*.class',
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'projects')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>fp', '<CMD>Telescope projects<CR>', { desc = '[F]ind [P]rojects' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily find in current buffer' })

      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Find in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
