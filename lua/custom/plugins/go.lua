return {
  -- Mini.icons Go file icons
  {
    'nvim-mini/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    },
  },

  -- Neotest Go adapter for running/debugging tests through Neotest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap',
      'leoluz/nvim-dap-go',
      'fredrikaverpil/neotest-golang',
    },
    opts = function()
      return {
        adapters = {
          require('neotest-golang') {
            dap_mode = 'dap-go',
            dap_go_opts = {
              delve = {
                detached = vim.fn.has 'win32' == 0,
              },
            },
          },
        },
      }
    end,
  },
}
