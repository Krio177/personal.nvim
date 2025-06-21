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
  -- JavaScript/TypeScript szerverek
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  -- ESLint szerver
  eslint = {
    settings = {
      codeActionOnSave = {
        enable = true,
        mode = 'all',
      },
      format = true,
      nodePath = '',
      onIgnoredFiles = 'off',
      packageManager = 'npm',
      rulesCustomizations = {},
      run = 'onType',
      useESLintClass = false,
      validate = 'on',
      workingDirectory = { mode = 'location' },
    },
  },
  -- Angular Language Server
  angularls = {
    filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx' },
    settings = {
      angular = {
        enable = true,
        experimental = {
          ivy = true,
        },
      },
    },
  },
  -- Deno LSP (alternatíva Node.js helyett)
  denols = {
    root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc'),
    settings = {
      deno = {
        enable = true,
        lint = true,
        unstable = true,
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
  -- JavaScript/TypeScript tooling
  'typescript-language-server',
  'angular-language-server',
  'deno',
})

local dap_servers = {
  'debugpy',
  'delve',
  'codelldb',
  'php-debug-adapter',
  'js-debug-adapter',
  'chrome-debug-adapter',
  'node-debug2-adapter',
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

-- Opcionális: TypeScript, JavaScript és Angular fájltípusok kezelése
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html' },
  callback = function()
    -- Beállítások specifikusan JS/TS/Angular fájlokhoz
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
