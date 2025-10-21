return {
  {
    'Exafunction/windsurf.vim',
    cmd = "Codeium",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "html", "css", "scss" },
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_filetypes = {
        TelescopePrompt = false,
      }
      vim.keymap.set('i', '<A-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<A-w>', function() return vim.fn['codeium#AcceptNextWord']() end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<A-.>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<A-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true })
    end
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = { "typst" },
    version = '1.*',
    opts = {},
  }
}
