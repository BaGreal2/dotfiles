local tsc_comp_group = vim.api.nvim_create_augroup("tsc_comp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("compiler tsc")
    local project_dir = vim.fn.findfile("tsconfig.json", ".;") -- searches upward
    if project_dir ~= "" then
      local tsconfig_path = vim.fn.fnamemodify(project_dir, ":p")
      vim.opt_local.makeprg = "npx tsc --noEmit --pretty false --project " .. tsconfig_path
    else
      vim.opt_local.makeprg = "npx tsc --noEmit --pretty false"
    end
  end,
  group = tsc_comp_group,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.axaml",
  callback = function() vim.bo.filetype = "axaml" end,
})
