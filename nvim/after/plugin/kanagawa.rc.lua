local pcall, kanagawa = pcall(require, 'kanagawa')
if (not pcall) then return end

kanagawa.setup({
  compile = true,
  transparent = true,
  commentStyle = { italic = false },
  background = {
    dark = "wave",
  },
  terminalColors = false,
})

vim.cmd('colorscheme kanagawa')
