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

    -- Rust adapter setup (using codelldb)
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- Alternative Rust adapter using lldb-vscode
    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-vscode',
      name = 'lldb',
    }

    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual', numhl = 'DiagnosticWarn' })

    -- Go configurations
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

    -- Helper function to get Rust executable
    local function get_rust_executable()
      local cwd = vim.fn.getcwd()
      local cargo_toml = cwd .. '/Cargo.toml'

      if vim.fn.filereadable(cargo_toml) == 1 then
        -- Read Cargo.toml to get package name
        local cargo_content = vim.fn.readfile(cargo_toml)
        local package_name = nil

        for _, line in ipairs(cargo_content) do
          local name_match = line:match '^name%s*=%s*"([^"]+)"'
          if name_match then
            package_name = name_match
            break
          end
        end

        if package_name then
          local executable = cwd .. '/target/debug/' .. package_name
          if vim.fn.executable(executable) == 1 then
            return executable
          end
        end
      end

      -- Fallback: let user choose
      return vim.fn.input('Path to executable: ', cwd .. '/target/debug/', 'file')
    end

    -- Rust configurations
    dap.configurations.rust = {
      {
        name = 'Launch (auto-detect)',
        type = 'codelldb',
        request = 'launch',
        program = get_rust_executable,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Launch (manual path)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
      {
        name = 'Launch with args',
        type = 'codelldb',
        request = 'launch',
        program = get_rust_executable,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = function()
          return tonumber(vim.fn.input 'Process ID: ')
        end,
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
        'codelldb', -- For Rust debugging
      },
    }

    -- DAP UI setup
    dapui.setup()
    dap.listeners.after.event_stopped['dapui_config'] = function()
      dapui.open()
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
