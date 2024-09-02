local status, neogit = pcall(require, 'neogit')
if (not status) then return end
local keymap = vim.keymap

neogit.setup({})

keymap.set('n', '<C-g>', ':Neogit<Return>', { silent = true })
