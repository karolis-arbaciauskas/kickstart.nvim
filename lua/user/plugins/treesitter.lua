return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'go',
      'gomod',
      'gosum',
      'gowork',
      'lua',
      'ruby',
      'yaml',
      'proto',
      'json',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
