return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go', -- Go debug adapter
  },
  keys = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- PHP adapter setup
    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter'
    local php_debug_js = mason_path .. '/extension/out/phpDebug.js'

    if vim.fn.filereadable(php_debug_js) == 1 then
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { php_debug_js },
      }
    else
      dap.adapters.php = {
        type = 'executable',
        command = 'php-debug-adapter',
        args = {},
      }
    end

    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual', numhl = 'DiagnosticWarn' })
    -- PHP configurations
    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug (stop on panic)',
        request = 'launch',
        program = '${file}',
        stopOnEntry = false,
        setupCommands = {
          {
            text = 'break runtime.throw',
            description = 'Stop on panic',
            ignoreFailures = true,
          },
        },
      },
    }

    -- GO adapter setup
    dap.adapters.go = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
        detached = not vim.fn.has 'win32',
      },
    }

    -- Mason setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve',
        'php-debug-adapter',
        'js-debug-adapter',
        'chrome-debug-adapter',
      },
    }

    -- DAP UI setup
    dapui.setup()
    dap.listeners.after.event_stopped['dapui_config'] = function()
      -- if not dapui.is_open() then
      dapui.open()
      -- end
    end

    -- DAP-GO setup
    require('dap-go').setup {
      delve = {
        args = { '--check-go-version=false' },
        detached = not vim.fn.has 'win32',
      },
    }
  end,
}
