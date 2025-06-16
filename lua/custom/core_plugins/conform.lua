return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
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
      go = { 'gofmt' },
      php = { 'pint' },
      python = { 'black', 'isort', 'mypy', 'ruff', 'flake8', 'pylint' },
      javascript = { 'prettierd', 'eslint_d' },
      typescript = { 'prettierd', 'eslint_d' },
      json = { 'prettierd', 'json-lsp' },
      yaml = { 'yamllint' },
      html = { 'prettierd', 'html-lsp' },
      css = { 'prettierd', 'css-lsp' },
      markdown = { 'markdownlint' },
      shell = { 'shfmt', 'shellcheck' },
      dockerfile = { 'dockerfile-language-server' },
      terraform = { 'tflint' },
      ansible = { 'ansible-lint', 'ansible-language-server' },
    },
  },
}
