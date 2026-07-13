vim.o.relativenumber = true
vim.g.have_nerd_font = true

-- Better colors
vim.o.termguicolors = true

-- No line wrap
vim.o.wrap = false

vim.o.colorcolumn = '100'

-- Disable swap files
vim.o.swapfile = false

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldlevel = 99
