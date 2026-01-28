return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      gopls = {},
      golangci_lint_ls = {},
      ruby_lsp = {},
      lua_ls = {},
    }

    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    for name, cfg in pairs(servers) do
      cfg.capabilities = capabilities
      vim.lsp.config(name, cfg)
      vim.lsp.enable(name)
    end
  end,
}
