local M = {}

-- Custom on_attach: semantic token fallback
local function custom_on_attach(client, bufnr)
  if not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = {
        tokenTypes = semantic.tokenTypes,
        tokenModifiers = semantic.tokenModifiers,
      },
      range = true,
    }
  end
end

M = {
  -- Extend Kickstart's LSP config
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          -- Your custom attach logic (merged with Kickstart's)
          on_attach = function(client, bufnr)
            -- run your custom one
            custom_on_attach(client, bufnr)

            -- also run Kickstart's on_attach if it exists
            local ks_attach = require('kickstart.plugins.lsp').on_attach
            if ks_attach then
              ks_attach(client, bufnr)
            end
          end,

          -- you can place gopls settings here if needed:
          -- settings = {
          --   gopls = { analyses = { unusedparams = true } }
          -- },
        },
      },
    },
  },

  -- neotest-golang
  {
    'fredrikaverpil/neotest-golang',
  },

  -- mini.icons overrides
  {
    'echasnovski/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    },
  },

  -- neotest adapter hookup
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

return M
