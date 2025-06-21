local capabilities = require('blink.cmp').get_lsp_capabilities()
local lsp_servers = {
  gopls = {},
  rust_analyzer = {},
  phpactor = {
    init_options = {
      format = true,
      rename = true,
      signatureHelp = true,
      hover = true,
      diagnostics = true,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}
local ensure_installed = vim.tbl_keys(lsp_servers or {})
vim.list_extend(ensure_installed, {
  'stylua',
  'markdownlint',
  'eslint-lsp',
  'eslint_d',
  'eslint',
  'prettierd',
  'prettier',
  'flake8',
  'black',
  'isort',
  'mypy',
  'pylint',
  'ruff',
  'kube-linter',
  'yamllint',
  'yamlfix',
  'shellcheck',
  'shfmt',
  'tflint',
  'ansible-language-server',
  'ansible-lint',
  'json-lsp',
  'phpcs',
  'phpmd',
  'pint',
  'yamllint',
  'css-lsp',
  'html-lsp',
  'bash-language-server',
  'dockerfile-language-server',
  'graphql-language-service-cli',
  'rustfmt',
})

local dap_servers = {
  'debugpy',
  'delve',
  'codelldb',
  'php-debug-adapter',
  'js-debug-adapter',
  'chrome-debug-adapter',
}
vim.list_extend(ensure_installed, dap_servers)

require('mason-tool-installer').setup { ensure_installed = ensure_installed }
require('mason-lspconfig').setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = lsp_servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}
