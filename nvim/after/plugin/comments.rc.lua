local status, comment = pcall(require, "Comment")
if (not status) then return end

comment.setup({
  toggler = {
    line = 'mm',
    block = 'MM'
  },
  opleader = {
    line = 'mm',
    block = 'MM',
  },
  -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
