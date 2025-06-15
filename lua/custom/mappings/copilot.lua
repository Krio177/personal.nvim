vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<cr>', { desc = 'Open Copilot Chat' })
vim.keymap.set('v', '<leader>cc', '<cmd>CopilotChatVisual<cr>', { desc = 'Open Copilot Chat with selection' })
vim.keymap.set('n', '<leader>ce', '<cmd>CopilotChatExplain<cr>', { desc = 'Copilot explain code' })
vim.keymap.set('n', '<leader>cr', '<cmd>CopilotChatFix<cr>', { desc = 'Copilot fix code' })
vim.keymap.set('n', '<leader>co', '<cmd>CopilotChatOptimize<cr>', { desc = 'Copilot optimize code' })

local map = vim.keymap.set
map('i', '<C-l>', function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = 'Copilot Accept ', noremap = true, silent = true })
return {}
