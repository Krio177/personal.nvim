return {
  'stevearc/oil.nvim',
  lazy = false, -- Ajánlott, hogy ne legyen lusta betöltés
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Ikonokhoz (opcionális, de ajánlott)
  keys = {
    { '<leader>fe', '<cmd>Oil --float<CR>', desc = 'File Explorer' },
    -- vagy a klasszikus: { "-", "<cmd>Oil<CR>", desc = "Parent directory" },
  },
  opts = {
    default_file_explorer = false, -- Oil legyen az alapértelmezett file explorer
    view_options = {
      show_hidden = true, -- Mutassa a rejtett fájlokat
    },
  },
}
