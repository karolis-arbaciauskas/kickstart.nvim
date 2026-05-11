vim.pack.add { 'https://github.com/vim-test/vim-test' }

vim.g['test#strategy'] = 'neovim_sticky'

vim.keymap.set('n', '<leader>tt', '<cmd>TestFile<CR>', { desc = 'Test file' })
vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<CR>', { desc = 'Test nearest' })
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<CR>', { desc = 'Test last' })
