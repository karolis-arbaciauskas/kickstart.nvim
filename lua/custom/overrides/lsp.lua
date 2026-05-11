-- Additional LSP servers (nvim-lspconfig + mason already loaded by kickstart init.lua)

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    if client:supports_method('textDocument/inlayHint', event.buf) then
      vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
    end
  end,
})

local servers = {
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  golangci_lint_ls = {},
  ruby_lsp = {},
}

-- mason-tool-installer.setup() replaces ensure_installed; combine with what
-- kickstart already requested (stylua, lua_ls) instead of overwriting.
local ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'stylua', 'lua_ls' })
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, cfg in pairs(servers) do
  cfg.capabilities = capabilities
  vim.lsp.config(name, cfg)
  vim.lsp.enable(name)
end
