return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- Prefer project-local eslint if available; fall back to global
      local cwd = vim.fn.getcwd()
      local local_eslint = cwd .. '/node_modules/.bin/eslint'
      if vim.fn.filereadable(local_eslint) == 1 then
        if lint.linters.eslint then
          lint.linters.eslint.cmd = local_eslint
        end
      end

      -- Only enable eslint-based linters when an executable is available
      local has_eslint = (vim.fn.filereadable(local_eslint) == 1) or (vim.fn.executable('eslint') == 1)

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        python = { 'ruff' },
        javascript = has_eslint and { 'eslint' } or nil,
        typescript = has_eslint and { 'eslint' } or nil,
        javascriptreact = has_eslint and { 'eslint' } or nil,
        typescriptreact = has_eslint and { 'eslint' } or nil,
        java = { 'checkstyle' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
