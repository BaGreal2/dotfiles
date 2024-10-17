require('base')
require('highlights')
require('maps')
require('plugin-setup')
require('commands')

-- Highlights linking (Needs to be here before initial draw)
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
