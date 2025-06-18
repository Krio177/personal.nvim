return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
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

    -- First, set up the PHP adapter and configurations BEFORE mason-nvim-dap
    -- This ensures the configurations are available when DAP initializes

    -- Debug: Check Mason installation path
    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/php-debug-adapter'
    local php_debug_js = mason_path .. '/extension/out/phpDebug.js'

    -- Try different adapter configurations
    if vim.fn.filereadable(php_debug_js) == 1 then
      -- Mason installed version
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { php_debug_js },
      }
    else
      -- Fallback to direct command
      dap.adapters.php = {
        type = 'executable',
        command = 'php-debug-adapter',
        args = {},
      }
    end

    -- PHP debugging configurations - Docker compatible
    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug (Docker)',
        port = 9194, -- Match your current Xdebug port
        pathMappings = {
          ['/var/www/html/MKOSZ/NYIL'] = vim.fn.getcwd(),
        },
        log = true,
        xdebugSettings = {
          max_children = 512,
          max_data = 1024,
          max_depth = 4,
        },
        -- Docker specific settings
        hostname = '0.0.0.0', -- Listen on all interfaces
      },
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug (Local - 9003)',
        port = 9003, -- Standard Xdebug 3 port
        pathMappings = {
          ['/var/www/html/MKOSZ/NYIL'] = vim.fn.getcwd(),
        },
        log = true,
        hostname = '127.0.0.1',
      },
    }

    -- Now set up mason-nvim-dap
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {
        -- Don't let mason override our PHP config
        ['php-debug-adapter'] = function(config)
          -- Keep our custom configuration
        end,
      },
      ensure_installed = {
        'delve',
        'php-debug-adapter',
        'js-debug-adapter',
        'chrome-debug-adapter',
      },
    }

    dap.listeners.after.event_stopped['dapui_config'] = function()
      -- Safe UI opening - only if not already open
      local ok, _ = pcall(function()
        if not require('dapui').is_open() then
          require('dapui').open()
        end
      end)
      if not ok then
        print 'DAP UI: Use <F7> or <leader>du to toggle manually'
      end
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- Debug function to check PHP configuration
  end,
}
