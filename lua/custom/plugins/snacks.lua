vim.pack.add { 'https://github.com/folke/snacks.nvim' }

-- Hidden from file/grep pickers. `exclude` globs are handed to fd as `-E` and
-- to ripgrep as `-g '!<glob>'`, so every pattern must work for both: ripgrep
-- matches the whole path, hence the `**/` prefixes.
local generated = {
  '**/mocks/**',
  '**/*.gen.go',
  '**/*.pb.go',
}

-- Same files as git pathspecs, for the pickers that shell out to `git ls-files`
-- and `git grep` instead of fd/ripgrep.
local generated_pathspec = {
  ':(exclude)**/mocks/**',
  ':(exclude)**/*.gen.go',
  ':(exclude)**/*.pb.go',
}

-- Toggles the excludes for the current picker only, so a single search can
-- include generated files again.
local function toggle_generated(picker)
  local opts = picker.opts
  local saved = opts._saved_generated
  if saved then
    opts.exclude, opts.cmd_args, opts.pathspec = saved.exclude, saved.cmd_args, saved.pathspec
    opts._saved_generated = nil
  else
    opts._saved_generated = { exclude = opts.exclude, cmd_args = opts.cmd_args, pathspec = opts.pathspec }
    opts.exclude, opts.cmd_args, opts.pathspec = {}, nil, nil
  end
  picker.list:set_target()
  picker:find()
end

require('snacks').setup {
  picker = {
    ui_select = true,
    sources = {
      files = { exclude = generated },
      grep = { exclude = generated },
      grep_word = { exclude = generated },
      grep_buffers = { exclude = generated },
      git_files = { cmd_args = generated_pathspec },
      git_grep = { pathspec = generated_pathspec },
    },
    actions = { toggle_generated = toggle_generated },
    win = {
      input = {
        keys = {
          ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
          ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
          ['<a-g>'] = { 'toggle_generated', mode = { 'i', 'n' }, desc = 'toggle generated/mocks' },
        },
      },
      list = {
        keys = {
          ['<c-u>'] = 'preview_scroll_up',
          ['<c-d>'] = 'preview_scroll_down',
          ['<a-g>'] = 'toggle_generated',
        },
      },
    },
  },
  lazygit = {},
  gitbrowse = {},
}

vim.ui.select = require('snacks.picker').select

-- Disable blink.cmp inside the Snacks picker prompt so <C-n>/<C-p> move the
-- selection (like Telescope) instead of cycling completion items.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_picker_input',
  callback = function(ev) vim.b[ev.buf].completion = false end,
})

vim.api.nvim_create_user_command('DeleteOtherBuffers', function() require('snacks').bufdelete.other() end, { desc = 'Delete Other Buffers' })

local map = vim.keymap.set

-- Git operations
map('n', '<leader>gg', function() Snacks.lazygit { cwd = vim.fn.getcwd() } end, { desc = 'Lazygit (Root Dir)' })
map('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
map('n', '<leader>gl', function() Snacks.lazygit.log { cwd = vim.fn.getcwd() } end, { desc = 'Lazygit Log' })
map('n', '<leader>gb', '<cmd>Gitsigns blame<cr>', { desc = 'Git blame' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>go', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })

-- Search operations
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', function() Snacks.picker.files() end, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', function() Snacks.picker() end, { desc = '[S]earch [S]elect Picker' })
map('n', '<leader>sw', function() Snacks.picker.grep_word() end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', function() Snacks.picker.recent() end, { desc = '[S]earch Recent Files' })
map('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = '[S]earch [C]ommands' })
map('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function() Snacks.picker.lines() end, { desc = '[/] Search in current buffer' })
map('n', '<leader>s/', function() Snacks.picker.grep_buffers() end, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
