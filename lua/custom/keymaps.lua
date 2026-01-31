local map = vim.keymap.set

-- Toggle oil file explorer
local function toggle_oil()
  if vim.bo.filetype == 'oil' then
    vim.cmd 'bd'
  else
    require('oil').open()
  end
end

map('n', '<leader>e', toggle_oil, { desc = 'Toggle Explorer' })

-- Window resizing
map('n', '<A-h>', '<C-w>5<', { desc = 'Decrease window width' })
map('n', '<A-l>', '<C-w>5>', { desc = 'Increase window width' })
map('n', '<A-j>', '<C-w>1+', { desc = 'Increase window height' })
map('n', '<A-k>', '<C-w>1-', { desc = 'Decrease window height' })

-- Move lines in visual mode
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })
