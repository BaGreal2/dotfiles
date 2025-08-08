return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css", "scss" },
    enabled = false,
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
  {
    'Exafunction/windsurf.vim',
    cmd = "Codeium",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css", "scss" },
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<A-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<A-w>', function() return vim.fn['codeium#AcceptNextWord']() end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<A-.>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<A-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true })
    end
  }
}
