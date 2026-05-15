vim.keymap.set('n', '<C-n>', ':cnext<CR>')
vim.keymap.set('n', '<C-p>', ':cprevious<CR>')

vim.keymap.set('n', '<leader>s', '1z=')

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

-- vim.api.nvim_create_user_command("Grep", function(opts)
--   local args = opts.args
--
--   vim.cmd("silent grep " .. args)

  -- if #vim.fn.getqflist() > 0 then
  --   vim.cmd("copen")
  -- end
-- end, {
--   nargs = "+",
--   complete = "file",
-- })

-- vim.keymap.set("n", ";f", function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":find ", true, false, true), "n", false)
-- end)
--
-- vim.keymap.set("n", ";r", function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Grep ", true, false, true), "n", false)
-- end)

vim.keymap.set("n", "ga", "<Cmd>buffer #<CR>", { noremap = true })
-- vim.keymap.set("n", "\\", ":buffer ", { noremap = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.j2",
  callback = function()
    vim.bo.filetype = "htmldjango"
  end,
})
