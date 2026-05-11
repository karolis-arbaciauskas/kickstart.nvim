vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  picker = { ui_select = true },
  lazygit = {},
  gitbrowse = {},
}

vim.ui.select = require('snacks.picker').select

vim.api.nvim_create_user_command('DeleteOtherBuffers', function() require('snacks').bufdelete.other() end, { desc = 'Delete Other Buffers' })

local map = vim.keymap.set

-- Git operations
map('n', '<leader>gg', function() Snacks.lazygit { cwd = vim.fn.getcwd() } end, { desc = 'Lazygit (Root Dir)' })
map('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
map('n', '<leader>gl', function() Snacks.lazygit.log { cwd = vim.fn.getcwd() } end, { desc = 'Lazygit Log' })
map('n', '<leader>gb', '<cmd>Gitsigns blame<cr>', { desc = 'Git blame' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>go', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })

-- Search operations
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', function() Snacks.picker.files() end, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', function() Snacks.picker() end, { desc = '[S]earch [S]elect Picker' })
map('n', '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', function() Snacks.picker.recent() end, { desc = '[S]earch Recent Files' })
map('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = '[S]earch [C]ommands' })
map('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function() Snacks.picker.lines() end, { desc = '[/] Search in current buffer' })
map('n', '<leader>s/', function() Snacks.picker.grep_buffers() end, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
