return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim',
  },
  event = 'VeryLazy',
  opts = function()
    return {
      options = {
        separator_style = 'slant',
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
            separator = true,
          },
        },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level == 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
      },
      highlights = require('catppuccin.groups.integrations.bufferline').get {
        custom = {
          all = {},
          macchiato = { -- vagy a választott flavour
            buffer_selected = { underline = true },
            tab_selected = { underline = true },
          },
        },
      },
    }
  end,
}
