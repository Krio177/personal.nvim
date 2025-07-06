return {
  'kylechui/nvim-surround',
  version = '^3.0.0',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      keymaps = {
        normal = 'gys',
        normal_cur = 'gyss',
        normal_line = 'gyS',
        normal_cur_line = 'gySS',
        visual = 'S',
        visual_line = 'gS',
        delete = 'gds',
        change = 'gcs',
        change_line = 'gcS',
      },
    }
  end,
}
