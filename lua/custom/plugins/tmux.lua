vim.pack.add { 'https://github.com/mrjones2014/smart-splits.nvim' }

require('smart-splits').setup {}

local map = vim.keymap.set
-- Navigation (replaces vim-tmux-navigator)
map('n', '<C-h>', function() require('smart-splits').move_cursor_left() end, { desc = 'Move to left split' })
map('n', '<C-j>', function() require('smart-splits').move_cursor_down() end, { desc = 'Move to below split' })
map('n', '<C-k>', function() require('smart-splits').move_cursor_up() end, { desc = 'Move to above split' })
map('n', '<C-l>', function() require('smart-splits').move_cursor_right() end, { desc = 'Move to right split' })
-- Resizing
map('n', '<A-h>', function() require('smart-splits').resize_left() end, { desc = 'Resize left' })
map('n', '<A-j>', function() require('smart-splits').resize_down() end, { desc = 'Resize down' })
map('n', '<A-k>', function() require('smart-splits').resize_up() end, { desc = 'Resize up' })
map('n', '<A-l>', function() require('smart-splits').resize_right() end, { desc = 'Resize right' })
