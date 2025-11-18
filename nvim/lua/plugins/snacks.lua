return {
  {
    'folke/snacks.nvim',
    event = 'VeryLazy',
    opts = {
      -- Smooth scrolling
      scroll = {
        enabled = true,
        -- You can customize scroll behavior here if needed
      },
      -- Distraction-free zen mode
      zen = {
        enabled = true,
        -- Customize zen mode settings if desired
      },
      -- Dim inactive code for better focus
      dim = {
        enabled = true,
        -- Customize dimming behavior if needed
      },
      -- Optimize handling of large files
      bigfile = {
        enabled = true,
        -- Automatically disables certain features for large files
      },
      -- Disable modules that overlap with your existing setup
      dashboard = { enabled = false }, -- You have mini.starter
      notifier = { enabled = false },  -- You have noice.nvim
      explorer = { enabled = false },  -- You have neo-tree
      picker = { enabled = true },     -- Required for git module pickers
      bufdelete = { enabled = false }, -- You have mini.bufremove
      indent = { enabled = false },    -- You have indent-blankline
      git = {
        enabled = true,
        -- Git module provides status, branches, log, diff, stash pickers
      },
      terminal = { enabled = false },  -- Only enable if you want terminal in Neovim
      image = { enabled = false },     -- Only if you use kitty/wezterm and need images
      animate = { enabled = false },   -- Optional animations
    },
    config = function(_, opts)
      require('snacks').setup(opts)

      -- Set up Git keymaps with descriptions for which-key
      -- These will automatically appear in which-key under <leader>g
      local map = vim.keymap.set

      -- Wait for snacks to be fully loaded before setting up keymaps
      vim.defer_fn(function()
        local snacks = require('snacks')
        if not snacks or not snacks.picker then
          vim.notify('snacks.nvim picker not available', vim.log.levels.WARN)
          return
        end

        -- Helper function to check if we're in a git repo
        local function is_git_repo()
          local cwd = vim.fn.getcwd()
          local git_dir = vim.fn.finddir('.git', cwd .. ';')
          return git_dir ~= ''
        end

        -- Git Status - shows working tree status
        -- Note: Shows "No results found" when working tree is clean (no changes)
        map('n', '<leader>gS', function()
          if not is_git_repo() then
            vim.notify('Not in a git repository', vim.log.levels.WARN)
            return
          end
          -- git_status shows modified/staged/untracked files
          -- If working tree is clean, it will show "No results found" (this is expected)
          pcall(function()
            snacks.picker('git_status')
          end)
        end, { desc = '[G]it [S]tatus (shows changes)' })

        -- Git Branches - list and switch branches
        map('n', '<leader>gB', function()
          if not is_git_repo() then
            vim.notify('Not in a git repository', vim.log.levels.WARN)
            return
          end
          pcall(function()
            snacks.picker('git_branches')
          end)
        end, { desc = '[G]it [B]ranches' })

        -- Git Log - commit history
        map('n', '<leader>gL', function()
          if not is_git_repo() then
            vim.notify('Not in a git repository', vim.log.levels.WARN)
            return
          end
          pcall(function()
            snacks.picker('git_log')
          end)
        end, { desc = '[G]it [L]og' })

        -- Git Diff - view changes
        map('n', '<leader>gD', function()
          if not is_git_repo() then
            vim.notify('Not in a git repository', vim.log.levels.WARN)
            return
          end
          pcall(function()
            snacks.picker('git_diff')
          end)
        end, { desc = '[G]it [D]iff' })

        -- Git Stash - manage stashes
        map('n', '<leader>gT', function()
          if not is_git_repo() then
            vim.notify('Not in a git repository', vim.log.levels.WARN)
            return
          end
          pcall(function()
            snacks.picker('git_stash')
          end)
        end, { desc = '[G]it S[t]ash' })
      end, 100)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et


