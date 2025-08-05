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
