return {
  -- { -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },
  {
    'saghen/blink.indent',
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    opts = {
      static = {
        highlights = { 'BlinkIndent' },
      },
      scope = {
        highlights = { 'BlinkIndentScope' },
        underline = {
          highlights = { 'BlinkIndentScopeUnderline' },
        },
      },
    },
  },
}
