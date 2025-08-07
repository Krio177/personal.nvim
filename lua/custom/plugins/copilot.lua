return {

  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true -- Tiltsa le a Tab alapértelmezett hozzárendelését
      vim.g.copilot_assume_mapped = true

      vim.api.nvim_set_keymap('i', '<silent> <C-S-n>', '<Plug>(copilot-next)', {})
      vim.api.nvim_set_keymap('i', '<silent> <C-S-p>', '<Plug>(copilot-previous)', {})
    end,
  },
}
