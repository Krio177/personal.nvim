return {
  -- Távolítsd el vagy kommenteld ki ezt a részt:
  -- {
  --   'github/copilot.vim',
  --   lazy = false,
  --   config = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.api.nvim_set_keymap('i', '<silent> <C-S-n>', '<Plug>(copilot-next)', {})
  --     vim.api.nvim_set_keymap('i', '<silent> <C-S-p>', '<Plug>(copilot-previous)', {})
  --   end,
  -- },

  -- Add hozzá ezt helyette:
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<C-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = '[[',
            jump_next = ']]',
            accept = '<CR>',
            refresh = 'gr',
            open = '<M-CR>',
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
      }
    end,
  },
}
