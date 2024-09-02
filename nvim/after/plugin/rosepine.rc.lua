local status, n = pcall(require, 'rose-pine')
if (not status) then return end

n.setup {
  varian = 'main',
  dark_varian = 'main',
  disable_italics = true,
  disable_background = true,
  disable_float_background = true,
}

vim.cmd('colorscheme rose-pine')
