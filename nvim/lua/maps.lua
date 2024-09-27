local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- keymap.set('n', 'dw', 'vb"_d')

keymap.set('n', '<C-a>', 'gg<S-v>G')

keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })

keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 's<left>', '<C-w>h')
keymap.set('', 's<up>', '<C-w>k')
keymap.set('', 's<down>', '<C-w>j')
keymap.set('', 's<right>', '<C-w>l')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

keymap.set('n', '<C-w><right>', '<C-w><')
keymap.set('n', '<C-w><left>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

keymap.set('n', 'TT', ':FTermToggle<Return>', { silent = true })
keymap.set('t', 'TT', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { silent = true })

vim.api.nvim_create_user_command('W', 'noa w', { nargs = 0 })

-- keymap.set('n', '<Space>tt', '<CMD>lua require("FTerm").toggle()<CR>')
-- keymap.set('t', '<Space>tt', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
