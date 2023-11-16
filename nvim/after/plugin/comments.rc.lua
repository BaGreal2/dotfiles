local status, comment = pcall(require, "Comment")
if (not status) then return end

comment.setup({
  toggler = {
    line = 'mm',
    block = 'mb'
  },
  opleader = {
    line = 'mm',
    block = 'mb',
  },
})
