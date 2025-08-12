local terminal_bufnr = nil
local terminal_winid = nil

function _G.toggle_terminal()
  if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
    vim.api.nvim_win_close(terminal_winid, true)
    terminal_winid = nil
    return
  end

  if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
    vim.cmd.vnew()
    terminal_winid = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
  else
    vim.cmd.vnew()
    terminal_winid = vim.api.nvim_get_current_win()
    vim.cmd.term()
    terminal_bufnr = vim.api.nvim_get_current_buf()
  end

  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert()
end

vim.keymap.set('n', '<leader>st', toggle_terminal)
vim.keymap.set('t', '<leader>st', [[<C-\><C-n>:lua toggle_terminal()<CR>]], { noremap = true, silent = true })
