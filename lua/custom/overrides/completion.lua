-- Extend blink.cmp with the copilot source (blink.cmp already loaded by kickstart init.lua).
--
-- blink.cmp.setup() replaces config (no merge API). Only restate non-default
-- values that kickstart explicitly sets, plus our additions.

vim.pack.add { 'https://github.com/fang2hou/blink-copilot' }

require('blink.cmp').setup {
  -- kickstart's non-default settings
  fuzzy = { implementation = 'lua' }, -- avoid prebuilt rust binary download
  signature = { enabled = true },

  -- our additions
  sources = {
    default = { 'copilot', 'lsp', 'path', 'snippets' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
      },
    },
  },
}
