-- Extend mini.icons with Go glyphs (mini.icons is already configured by kickstart's mini.nvim)
local mini_icons = require 'mini.icons'

mini_icons.setup(vim.tbl_deep_extend('force', mini_icons.config or {}, {
  file = {
    ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
  },
  filetype = {
    gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
  },
}))
