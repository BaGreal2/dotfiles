local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- keymap.set('n', 'dw', 'vb"_d')

keymap.set('n', '<C-a>', 'gg<S-v>G')

keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })

keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

keymap.set('n', '<C-w>h', '<C-w><<C-w><<C-w><<C-w><')
keymap.set('n', '<C-w>l', '<C-w>><C-w>><C-w>><C-w>>')
keymap.set('n', '<C-w>k', '<C-w>+<C-w>+<C-w>+<C-w>+')
keymap.set('n', '<C-w>j', '<C-w>-<C-w>-<C-w>-<C-w>-')
keymap.set('n', '<leader>h', ':wincmd H<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>l', ':wincmd L<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>k', ':wincmd K<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>j', ':wincmd J<CR>', { noremap = true, silent = true })

keymap.set('n', 'TT', ':FTermToggle<Return>', { silent = true })
keymap.set('t', 'TT', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { silent = true })

keymap.set('n', '<C-k>', 'q:i', { silent = true })

keymap.set('n', '<C-f>', ':Esfix<Return>')
keymap.set('n', '<C-c>', ':Compile<Return>')

vim.api.nvim_create_user_command('W', 'noa w', { nargs = 0 })
