vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_set_keymap('n', 'y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'y', '"+y', { noremap = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
vim.keymap.set('n', '<leader><Tab>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon quick menu' })
vim.keymap.set('n', '<C-o>', function()
  harpoon:list():next()
end, { desc = 'Harpoon next' })
vim.keymap.set('n', '<C-p>', function()
  harpoon:list():prev()
end, { desc = 'Harpoon previous' })
local opts = { noremap = true, silent = true }

-- Következő/előző buffer
map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', opts)
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', opts)

-- <leader>b prefix alatt
local leader_b = '<leader>b'

-- Buffer bezárása
map('n', leader_b .. 'x', '<cmd>bp | bd #<CR>', { desc = 'Buffer bezárása' })

-- Buffer kiválasztása (pick mode)
map('n', leader_b .. 'o', '<cmd>BufferLinePick<CR>', { desc = 'Buffer kiválasztása' })

-- Buffer pin/unpin
map('n', leader_b .. 'p', '<cmd>BufferLineTogglePin<CR>', { desc = 'Buffer pin/unpin' })

-- Összes buffer bezárása, kivéve az aktuálisat
map('n', leader_b .. 'c', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Többi buffer bezárása' })

-- Bal/jobb összes buffer bezárása
map('n', leader_b .. 'bl', '<cmd>BufferLineCloseRight<CR>', { desc = 'Jobbra lévő bufferek bezárása' })
map('n', leader_b .. 'bh', '<cmd>BufferLineCloseLeft<CR>', { desc = 'Balra lévő bufferek bezárása' })
-- Buffer áthelyezése balra/jobbra
map('n', leader_b .. '<', '<cmd>BufferLineMovePrev<CR>', { desc = 'Buffer balra mozgatása' })
map('n', leader_b .. '>', '<cmd>BufferLineMoveNext<CR>', { desc = 'Buffer jobbra mozgatása' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'LSP diagnosztikák QuickFix-be' })
-- Kényelmes mapping: diagnosztikák quickfix-be + megnyitás
vim.keymap.set('n', '<leader>co', function()
  vim.diagnostic.setqflist()
  vim.cmd 'copen'
end, { desc = 'Diagnosztikák QuickFix-be és megnyitás' })

-- Clipboard copy/paste mappings
-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+yg_', { desc = 'Copy to end of line to clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Copy whole line to clipboard' })

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard after cursor' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from clipboard' })

vim.keymap.set('n', '<leader>P', ':Telescope neoclip<CR>', { desc = 'Open Neoclip Yank History' })
