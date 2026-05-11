-- Extend conform.nvim (already loaded by kickstart init.lua).
--
-- conform.setup() merges `formatters_by_ft` but REPLACES `format_on_save` and
-- `default_format_opts`. To preserve kickstart's settings, restate them.

require('conform').setup {
  notify_on_error = false, -- from kickstart
  default_format_opts = { lsp_format = 'fallback' }, -- from kickstart
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == 'go' then return { timeout_ms = 1000, lsp_format = 'first' } end
    return { timeout_ms = 1000, lsp_format = 'fallback' }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    yaml = { 'prettierd' },
  },
}
