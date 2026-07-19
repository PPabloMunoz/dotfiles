-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Custom keymaps
vim.keymap.set('i', 'jk', '<Esc>')

-- Oil keymap
vim.keymap.set('n', '-', vim.cmd.Oil, { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Oil, { desc = 'Open parent directory' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Cop[Y] to Clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy full line to clipboard' })

-- Quickfixes
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>qf', function()
  vim.lsp.buf.code_action({ apply = true })
end, { desc = 'Quick [F]ix' })
