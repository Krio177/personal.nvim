return {
  'yetone/avante.nvim',
  build = function()
    if vim.fn.has 'win32' == 1 then
      return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
    else
      return 'make'
    end
  end,
  event = 'VeryLazy',
  version = false,
  opts = {
    provider = 'copilot', -- Itt változtasd meg "claude"-ról "copilot"-ra!
    -- providers = { ... }, -- Ezt a részt elhagyhatod, ha csak Copilot-ot használsz
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.pick',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'ibhagwan/fzf-lua',
    'stevearc/dressing.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua', -- Ez fontos a Copilot integrációhoz!
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- ...
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
