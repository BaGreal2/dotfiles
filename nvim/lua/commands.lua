----------- Toggle window layout -----------

vim.g.maximized_window = 0

function ToggleMaximize()
  if vim.g.maximized_window == 0 then
    vim.cmd('wincmd _')
    vim.cmd('wincmd |')
    vim.g.maximized_window = 1
  else
    local windows = vim.fn.getwininfo()
    if #windows > 1 then
      vim.cmd('wincmd =')
    end
    vim.g.maximized_window = 0
  end
end

vim.api.nvim_set_keymap('n', '<Leader>w', ':lua ToggleMaximize()<CR>', { noremap = true, silent = true })

-- Terminal hardening: no Treesitter, no statuscolumn/signcolumn in the term window
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(ev)
    pcall(vim.treesitter.stop, ev.buf)
    vim.schedule(function()
      local win = vim.fn.bufwinid(ev.buf)
      if win ~= -1 then
        vim.wo[win].statuscolumn = ''
        vim.wo[win].signcolumn = 'no'
        vim.wo[win].cursorline = false
      end
    end)
  end,
})

local function term_prompt(size)
  size = size or 10
  local cmd = vim.fn.input('term> ', vim.g._last_term_cmd or '', 'shellcmd')
  if cmd == '' then return end
  vim.g._last_term_cmd = cmd

  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[term_buf].bufhidden = 'wipe'

  vim.cmd('belowright ' .. size .. 'split')
  local term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(term_win, term_buf)

  vim.api.nvim_buf_call(term_buf, function()
    vim.fn.termopen({ vim.o.shell, '-lc', cmd })
  end)
end

vim.keymap.set('n', '<leader>t', function() term_prompt(10) end)

vim.keymap.set('n', '<leader>T', function()
  if not vim.g._last_term_cmd then return end

  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[term_buf].bufhidden = 'wipe'
  vim.cmd('belowright 10split')
  local term_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(term_win, term_buf)
  vim.api.nvim_buf_call(term_buf, function()
    vim.fn.termopen({ vim.o.shell, '-lc', vim.g._last_term_cmd })
  end)
end)
