vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<cr>', { desc = 'Open Copilot Chat' })
vim.keymap.set('v', '<leader>cc', '<cmd>CopilotChatVisual<cr>', { desc = 'Open Copilot Chat with selection' })
vim.keymap.set('n', '<leader>ce', '<cmd>CopilotChatExplain<cr>', { desc = 'Copilot explain code' })
vim.keymap.set('n', '<leader>cr', '<cmd>CopilotChatFix<cr>', { desc = 'Copilot fix code' })
vim.keymap.set('n', '<leader>co', '<cmd>CopilotChatOptimize<cr>', { desc = 'Copilot optimize code' })

local map = vim.keymap.set
map('i', '<C-l>', function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = 'Copilot Accept ', noremap = true, silent = true })
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
