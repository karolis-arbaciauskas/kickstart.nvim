-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  require 'custom.plugins.lsp',
  require 'custom.plugins.completion',
  require 'custom.plugins.formatting',
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.treesitter',
  require 'custom.plugins.snacks',
  require 'custom.plugins.copilot',
  require 'custom.plugins.go',
  require 'custom.plugins.other',
  require 'custom.plugins.vim_test',
  require 'custom.plugins.tmux',
  require 'custom.plugins.oil',
}
