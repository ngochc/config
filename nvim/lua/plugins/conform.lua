return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      -- Format the whole buffer
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = 'n',
        desc = '[C]ode [F]ormat buffer',
      },
      -- Format a visual selection
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback', range = true }
        end,
        mode = 'x',
        desc = '[C]ode [F]ormat selection',
      },
      -- Toggle format on save
      {
        '<leader>tf',
        function()
          vim.g.autoformat_on_save = not vim.g.autoformat_on_save
          local msg = 'Format on save: ' .. (vim.g.autoformat_on_save and 'ON' or 'OFF')
          if vim.notify then vim.notify(msg) else print(msg) end
        end,
        mode = 'n',
        desc = '[T]oggle [F]ormat on save',
      },
      -- Format only changed lines (git diff)
      {
        '<leader>cF',
        function()
          local conform = require 'conform'
          -- Get git hunks (changed lines)
          local hunks = vim.fn.systemlist('git diff --unified=0 ' .. vim.fn.expand '%')
          if vim.v.shell_error ~= 0 then
            vim.notify('Not in a git repository or file not tracked', vim.log.levels.WARN)
            return
          end

          -- Parse hunks to get line ranges
          local ranges = {}
          for _, line in ipairs(hunks) do
            local start_line, line_count = line:match '^@@.*%+(%d+),?(%d*)'
            if start_line then
              start_line = tonumber(start_line)
              line_count = tonumber(line_count) or 1
              table.insert(ranges, {
                start = { start_line, 0 },
                ['end'] = { start_line + line_count - 1, 0 },
              })
            end
          end

          if #ranges == 0 then
            vim.notify('No changes to format', vim.log.levels.INFO)
            return
          end

          -- Format each range
          for _, range in ipairs(ranges) do
            conform.format {
              async = true,
              lsp_format = 'fallback',
              range = range,
            }
          end
          vim.notify('Formatted ' .. #ranges .. ' changed region(s)', vim.log.levels.INFO)
        end,
        mode = 'n',
        desc = '[C]ode [F]ormat changed lines only (git)',
      },
    },
    opts = {
      notify_on_error = false,
      -- Global toggle for format on save
      format_on_save = function(bufnr)
        if vim.g.autoformat_on_save == nil then vim.g.autoformat_on_save = true end
        if not vim.g.autoformat_on_save then return nil end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Python
        python = { 'ruff_organize_imports', 'ruff_format', 'black' },
        -- JavaScript / TypeScript / JSON / Markdown
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        -- Go
        go = { 'goimports', 'gofmt' },
        -- Java
        java = { 'google-java-format' },
      },
      -- Optional: per-formatter settings (only when installed)
      formatters = {
        ['google-java-format'] = {
          prepend_args = { '--aosp' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
