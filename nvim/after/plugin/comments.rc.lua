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
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
