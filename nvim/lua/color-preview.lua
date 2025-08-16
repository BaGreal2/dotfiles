local match_id = nil

vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
  callback = function()
    if match_id then
      pcall(vim.fn.matchdelete, match_id)
      match_id = nil
    end

    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col('.')
    local s, e = line:find("#%x%x%x%x%x%x", 1)

    if s and col >= s and col <= e then
      local hex = line:sub(s, e)
      vim.api.nvim_set_hl(0, "ColorPreview", { bg = hex })
      match_id = vim.fn.matchadd("ColorPreview", hex)
    end
  end
})
