return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/nvim-nio',
      -- Adapters
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'rcasia/neotest-java',
    },
    keys = {
      { '<leader>nt', function() require('neotest').run.run() end, desc = '[N]eotest: Run nearest [T]est' },
      { '<leader>nf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = '[N]eotest: Run [F]ile' },
      { '<leader>nd', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = '[N]eotest: [D]ebug nearest test' },
      { '<leader>ns', function() require('neotest').run.stop() end, desc = '[N]eotest: [S]top' },
      { '<leader>na', function() require('neotest').run.attach() end, desc = '[N]eotest: [A]ttach' },
      { '<leader>no', function() require('neotest').output.open({ enter = true }) end, desc = '[N]eotest: [O]utput' },
      { '<leader>nO', function() require('neotest').output_panel.toggle() end, desc = '[N]eotest: [O]utput panel' },
      { '<leader>nS', function() require('neotest').summary.toggle() end, desc = '[N]eotest: [S]ummary' },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go'),
          require('neotest-python')({
            dap = { justMyCode = false },
            runner = 'pytest',
          }),
          require('neotest-java')({
            ignore_wrapper = false,
          }),
        },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
