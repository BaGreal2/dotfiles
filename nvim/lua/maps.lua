local keymap = vim.keymap

keymap.set('n', '<C-n>', ':cnext<CR>')
keymap.set('n', '<C-p>', ':cprevious<CR>')

keymap.set('n', '<leader>s', '1z=')

local function feed(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

local function close_tag()
  if vim.fn.mode() == "i" then feed("<C-\\><C-n>") end
  feed([[F<lyiWf>a<C-r>"<Esc>bi/<Esc>cit]])
end

vim.keymap.set({ "n", "i" }, "<C-t>", close_tag, { silent = true })
vim.keymap.set({ "n", "i" }, "<leader>t", close_tag, { silent = true })
vim.keymap.set("i", "<leader>d", '<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>')
vim.keymap.set("n", "<leader>d", 'i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>')
