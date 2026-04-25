-- LSP keymaps using Snacks picker
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom-lsp-snacks-keymaps', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Navigation with Snacks picker
    map('grd', function()
      Snacks.picker.lsp_definitions()
    end, '[G]oto [D]efinition')
    map('grr', function()
      Snacks.picker.lsp_references()
    end, '[G]oto [R]eferences')
    map('gri', function()
      Snacks.picker.lsp_implementations()
    end, '[G]oto [I]mplementation')
    map('grt', function()
      Snacks.picker.lsp_type_definitions()
    end, '[G]oto [T]ype Definition')

    -- Symbols
    map('gO', function()
      Snacks.picker.lsp_symbols()
    end, 'Document Symbols')
    map('gW', function()
      Snacks.picker.lsp_workspace_symbols()
    end, 'Workspace Symbols')

    -- Other LSP actions (not picker-based)
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  end,
  desc = 'LSP keymaps with Snacks picker',
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos('.', save_cursor)
  end,
  desc = 'Remove trailing whitespace',
})

-- Update file on focus if it was changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime',
  desc = 'Check if file changed outside of Neovim',
})

-- Detect Avro IDL files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.avdl',
  callback = function()
    vim.bo.filetype = 'avro-idl'
  end,
  desc = 'Set filetype for Avro IDL files',
})

-- Quickfix keymaps
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= 'quickfix' then
      return
    end

    local function clamp(target, min, max)
      return math.max(min, math.min(target, max))
    end

    local function clamp_linecount(target)
      return clamp(target, 1, vim.api.nvim_buf_line_count(0))
    end

    -- Delete single entry in quickfix
    vim.keymap.set('n', 'dd', function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local entries = vim.fn.getqflist()
      table.remove(entries, cursor[1])
      vim.fn.setqflist(entries)
      vim.api.nvim_win_set_cursor(0, { clamp_linecount(cursor[1]), cursor[2] })
    end, { buffer = ev.buf, desc = 'Delete quickfix entry' })

    -- Delete multiple entries in quickfix
    vim.keymap.set('v', 'd', function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local from, to = vim.fn.line 'v', vim.fn.line '.'
      local qf = {}
      for i, v in ipairs(vim.fn.getqflist()) do
        if i < from or i > to then
          table.insert(qf, v)
        end
      end
      vim.fn.setqflist(qf)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, true, true), 'nv', false)
      vim.api.nvim_win_set_cursor(0, { clamp_linecount(from), cursor[2] })
    end, { buffer = ev.buf, desc = 'Delete quickfix entries' })
  end,
  desc = 'Setup quickfix keymaps',
})
