local keymap = vim.keymap

keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })

keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

keymap.set('n', '<M-k>', 'q:i', { silent = true })

keymap.set('n', '<C-n>', '<cmd>cnext<cr>')
keymap.set('n', '<C-p>', '<cmd>cprevious<cr>')
