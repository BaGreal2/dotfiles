return {
  {
    'zbirenbaum/copilot.lua',
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css", "scss" },
    cmd = { "Copilot" },
    config = function()
      local on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.cmd("Copilot")
          end,
        })
      end

      require('copilot').setup({
        on_attach = on_attach,
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false
        }
      })
    end
  },
}
