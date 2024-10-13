vim.api.nvim_create_autocmd("BufRead", {
  pattern = "/Users/macbook/Developer/Work/Vektor/vektor-dashboard-frontend/*",
  callback = function()
    print("Lsp formatting disabled for this project.")
    vim.cmd("DisableLspFormatting")
  end,
})
