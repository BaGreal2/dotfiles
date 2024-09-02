local status, markdown = pcall(require, "render-markdown")
if (not status) then return end

markdown.setup({})
