vim.pack.add {
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/fredrikaverpil/neotest-golang',
}

require('neotest').setup {
  adapters = {
    require 'neotest-golang' {
      dap_mode = 'dap-go',
      dap_go_opts = {
        delve = {
          detached = vim.fn.has 'win32' == 0,
        },
      },
    },
  },
}
