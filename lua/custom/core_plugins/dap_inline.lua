return {
  'theHamsta/nvim-dap-virtual-text',
  lazy = false,
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('nvim-dap-virtual-text').setup()
  end,
}
