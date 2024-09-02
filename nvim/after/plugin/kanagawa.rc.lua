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

-- Disable backgrounds for kanagawa theme
-- Line numbers
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#54546d', bg = '' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#ff9e3b", bold = true, bg = '' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#54546d', bg = '' })
-- Git Signs
vim.api.nvim_set_hl(0, 'SignColumn', { fg = "#938aa9", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = "#76946a", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = "#76946a", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = "#dca561", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = "#dca561", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = "#c34043", bg = '' })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = "#c34043", bg = '' })
