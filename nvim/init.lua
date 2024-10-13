require('base')
require('highlights')
require('maps')
require('plugins')
require('commands')
require('autocmd')

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('macos')
end

if is_win then
  require('windows')
end

-- Highlights linking (Needs to be here before initial draw)
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "TelescopeBorder" })
