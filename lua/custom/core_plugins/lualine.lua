return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- A toolbar.lua fájlban lévő konfiguráció betöltése
      require 'toolbar'
    end,
  },
}
