return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = false,  -- Disable default to allow tmux navigation
      ['<C-l>'] = false,  -- Disable default to allow tmux navigation
    },
  },
}
