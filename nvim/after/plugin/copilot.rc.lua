local status, copilot = pcall(require, "copilot")
if (not status) then return end

local on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.cmd("Copilot")
    end,
  })
end


copilot.setup({
  on_attach = on_attach,
  suggestion = {
    auto_trigger = true,
    hide_during_completion = false
  }
})
