return {
  'rcarriga/nvim-dap-ui',
  keys = {
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug UI Toggle',
      silent = true,
    },
  },
  opts = {
    icons = { expanded = '∩â¥', collapsed = '∩âÜ', circular = '∩äÉ' },
    mappings = {
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      edit = 'e',
      repl = 'r',
      toggle = 't',
    },
    layouts = {
      {
        elements = {
          { id = 'repl', size = 0.30 },
          { id = 'console', size = 0.70 },
        },
        size = 0.19,
        position = 'bottom',
      },
      {
        elements = {
          { id = 'scopes', size = 0.30 },
          { id = 'breakpoints', size = 0.20 },
          { id = 'stacks', size = 0.10 },
          { id = 'watches', size = 0.30 },
        },
        size = 0.20,
        position = 'right',
      },
    },
    controls = {
      enabled = true,
      element = 'repl',
      pause = '',
      play = '',
      step_into = '',
      step_over = '',
      step_out = '',
      step_back = '',
      run_last = '↻',
      terminate = '',
    },
    floating = {
      max_height = 0.9,
      max_width = 0.5,
      border = vim.g.border_chars,
      mappings = {
        border = vim.g.border_chars or 'rounded',
      },
    },
  },
  config = function(_, opts)
    local icons = {
      Breakpoint = '',
      Stopped = '',
      -- adj hozzá további ikonokat, ha szükséges
    }
    for name, sign in pairs(icons) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define('Dap' .. name, { text = sign[1] })
    end
    require('dapui').setup(opts)
  end,
}
