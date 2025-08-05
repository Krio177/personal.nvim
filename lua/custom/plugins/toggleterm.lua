return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<leader>tt]],
        direction = 'horizontal',
        insert_mappings = true,
        terminal_mappings = true,
        start_in_insert = true,
        close_on_exit = true,
      }
    end,
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = 'Open terminal' },
    },
    cmd = 'ToggleTerm',
  },
}
