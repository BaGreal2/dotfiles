local status, fterm = pcall(require, 'FTerm')
if (not status) then return end

fterm.setup({
  border     = 'rounded',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

vim.api.nvim_create_user_command('FTermToggle', fterm.toggle, { bang = true })
