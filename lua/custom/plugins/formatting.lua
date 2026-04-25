return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == 'go' then
        -- Use gopls for Go: organize imports + format (instant, warm cache)
        vim.lsp.buf.code_action {
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
          apply = true,
        }
        return { timeout_ms = 1000, lsp_format = 'first' }
      end
      return { timeout_ms = 1000, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      yaml = { 'prettierd' },
    },
  },
}
