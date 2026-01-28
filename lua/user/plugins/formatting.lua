return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    formatters_by_ft = {
      go = { 'goimports' },
      lua = { 'stylua' },
      yaml = { 'prettierd' },
    },
  },
}
