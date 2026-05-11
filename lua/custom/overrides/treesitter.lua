-- Install extra parsers (nvim-treesitter already loaded by kickstart init.lua)

require('nvim-treesitter').install { 'go', 'gomod', 'gosum', 'gowork' }
