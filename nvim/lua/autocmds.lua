local tsc_comp_group = vim.api.nvim_create_augroup("tsc_comp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("compiler tsc")
    vim.opt_local.makeprg = "npx tsc --noEmit --pretty false"
  end,
  group = tsc_comp_group,
})

