local status, fterm = pcall(require, 'FTerm')
if (not status) then return end

vim.api.nvim_create_user_command('FTermToggle', fterm.toggle, { bang = true })
