local keymap = vim.keymap

keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })

keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

keymap.set('n', '<leader>h', ':wincmd H<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>l', ':wincmd L<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>k', ':wincmd K<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>j', ':wincmd J<CR>', { noremap = true, silent = true })

keymap.set('n', '<M-k>', 'q:i', { silent = true })
