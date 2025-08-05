return {
  {
    "zenbones-theme/zenbones.nvim",
    lazy = false,
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
    config = function()
      vim.g.zenbones = {
        transparent_background = true
      }
      vim.cmd.colorscheme('zenbones')
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    ft = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'lua', 'conf', 'kitty' },
    config = function()
      require('colorizer').setup({ '*' })
    end
  },
}
