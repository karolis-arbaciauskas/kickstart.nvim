return {
  'nvim-treesitter/nvim-treesitter',
  opts = function(_, opts)
    -- Map .avdl files to use the custom AVDL syntax
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
      pattern = '*.avdl',
      callback = function()
        vim.bo.filetype = 'avdl'
      end,
    })
  end,
}
