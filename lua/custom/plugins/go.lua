return {
  -- Go test adapter
  {
    'fredrikaverpil/neotest-golang',
  },

  -- Mini.icons Go file icons
  {
    'echasnovski/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    },
  },

  -- Neotest with Go adapter
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = { 'fredrikaverpil/neotest-golang' },
    opts = {
      adapters = {
        ['neotest-golang'] = {
          dap_go_enabled = true,
        },
      },
    },
  },
}
