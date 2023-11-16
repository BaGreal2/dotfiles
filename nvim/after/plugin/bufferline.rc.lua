local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'thin',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    separator = {
      fg = '#868A91',
      bg = '#191C21',
    },
    separator_selected = {
      fg = '#ABB2BF',
    },
    background = {
      fg = '#868A91',
      bg = '#191C21'
    },
    buffer_selected = {
      fg = '#ffffff',
      bold = true
    },
    fill = {
      bg = '#191C21'
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
