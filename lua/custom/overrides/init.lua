-- Auto-load every Lua file in this directory.
-- Files here run AFTER kickstart and all custom/plugins/*.lua, so they're free
-- to re-call setup() or mutate config of plugins already loaded by kickstart.
local dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'overrides')
local files = {}
for file_name, type in vim.fs.dir(dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then table.insert(files, file_name) end
end
table.sort(files)
for _, file_name in ipairs(files) do
  require('custom.overrides.' .. file_name:gsub('%.lua$', ''))
end
