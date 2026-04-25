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

-- Move lines in visual mode
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })
