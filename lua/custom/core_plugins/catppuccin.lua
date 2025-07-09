return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato', -- vagy latte, frappe, macchiato
        transparent_background = false, -- ha szeretnéd
        integrations = {
          harpoon = true,
          avante = true,
          neotree = true,
          dap_ui = true,
          cmp = true,
          gitsigns = true,
          telescope = true,
          treesitter = true,
          notify = true,
          which_key = true,
          lsp_trouble = true,
          lsp_saga = true,
          markdown = true,
          indent_blankline = {
            enabled = true, -- ha szeretnéd
            colored_indent_levels = false, -- ha szeretnéd
          },
          blink_cmp = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
