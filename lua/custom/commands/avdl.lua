-- Detect Avro IDL files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.avdl',
  callback = function()
    vim.bo.filetype = 'avro-idl'
  end,
})
