-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, { command = 'checktime' })

vim.keymap.set('n', '<A-h>', '<C-w>5<', { desc = 'Decrease window width' })
vim.keymap.set('n', '<A-l>', '<C-w>5>', { desc = 'Increase window width' })
vim.keymap.set('n', '<A-j>', '<C-w>1+', { desc = 'Increase window height' })
vim.keymap.set('n', '<A-k>', '<C-w>1-', { desc = 'Decrease window height' })

return {}
