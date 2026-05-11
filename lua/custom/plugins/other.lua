vim.pack.add { 'https://github.com/rgroli/other.nvim' }

require('other-nvim').setup {
  mappings = {
    'golang',
    { pattern = '/app/(.*)/(.*).rb', target = { { context = 'test', target = '/spec/%1/%2_spec.rb' } } },
    { pattern = '(.+)/spec/(.*)/(.*)_spec.rb', target = { { target = '%1/app/%2/%3.rb' } } },
  },
}

vim.keymap.set('n', '<leader>to', function() require('other-nvim').open() end)
vim.keymap.set('n', '<leader>tO', function() require('other-nvim').openVSplit() end)
