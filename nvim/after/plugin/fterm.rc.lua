local status, fterm = pcall(require, 'FTerm')
if (not status) then return end

fterm.setup({
  border     = 'rounded',
  dimensions = {
    height = 0.8,
    width = 0.8,
  },
})

vim.api.nvim_create_user_command('FTermToggle', fterm.toggle, { bang = true })
