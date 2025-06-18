return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup {
      mappings = {
        add = 'gsa', -- körülvevés hozzáadása
        delete = 'gsd', -- körülvevés törlése
        replace = 'gsr', -- körülvevés cseréje
        find = 'gsf', -- keresés jobbra
        find_left = 'gsF', -- keresés balra
        highlight = 'gsh', -- kiemelés
        update_n_lines = 'gsn', -- keresési tartomány frissítése
      },
    }
    local statusline = require 'mini.statusline'
    statusline.section_location = function()
      return '%2l:%-2v'
    end
    statusline.setup { use_icons = vim.g.have_nerd_font }
  end,
}
