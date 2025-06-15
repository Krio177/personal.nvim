local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
vim.keymap.set('n', '<C-S-A>', function()
  harpoon:list():add()
end, { desc = 'Harpoon add file' })
vim.keymap.set('n', '<C-S-E>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon quick menu' })
vim.keymap.set('n', '<C-o>', function()
  harpoon:list():next()
end, { desc = 'Harpoon next' })
vim.keymap.set('n', '<C-p>', function()
  harpoon:list():prev()
end, { desc = 'Harpoon previous' })
return {}
