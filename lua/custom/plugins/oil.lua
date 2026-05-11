vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<C-h>'] = false, -- Disable default to allow tmux navigation
    ['<C-l>'] = false, -- Disable default to allow tmux navigation
  },
}
