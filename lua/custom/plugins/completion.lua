return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  dependencies = {
    'fang2hou/blink-copilot',
    'L3MON4D3/LuaSnip',
  },
  opts = {
    sources = {
      default = { 'copilot', 'lsp', 'path', 'snippets' },
    },
  },
}
