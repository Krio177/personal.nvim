return {
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- kötelező, ha a Telescope integrációt használod
      -- opcionálisan: "ibhagwan/fzf-lua", ha az fzf-lua interfészt részesíted előnyben
      'kkharji/sqlite.lua', -- a tartós (persistent) történethez szükséges
    },
    config = function()
      require('neoclip').setup {
        enable_persistent_history = true, -- tartós historia használata sqlite segítségével
        continuous_sync = true, -- folyamatos szinkronizálás több Neovim példány között
        length_limit = 1048576, -- max 1 MiB elsődleges limit az eltárolt szövegre
        filter = function(data)
          -- Csak a yank műveleteket tárolja el (nem a delete, change, stb.)
          return data.event.operator == 'y'
        end,
        on_paste = {
          set_reg = false,
          move_to_front = false,
          close_telescope = true,
        },
        on_select = {
          move_to_front = false,
          close_telescope = true,
        },
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-k>',
              replay = '<c-q>',
              delete = '<c-d>',
              edit = '<c-e>',
            },
            n = {
              select = '<cr>',
              paste = 'p',
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
              edit = 'e',
            },
          },
        },
      }
    end,
  },
}
