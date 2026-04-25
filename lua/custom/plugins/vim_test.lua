return {
  'vim-test/vim-test',
  dependencies = { 'preservim/vimux' },
  init = function()
    vim.g['test#strategy'] = 'neovim_sticky'
  end,
  keys = {
    { '<leader>tt', '<cmd>TestFile<CR>', desc = 'Test file' },
    { '<leader>tn', '<cmd>TestNearest<CR>', desc = 'Test nearest' },
    { '<leader>tl', '<cmd>TestLast<CR>', desc = 'Test last' },
  },
}
