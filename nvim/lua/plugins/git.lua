return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>gb', '<Cmd>Gitsigns blame_line<CR>', {})
    end
  },
  {
    'dinhhuy258/git.nvim',
    config = function()
      require('git').setup({
        keymaps = {
          blame = ""
        }
      })
    end
  }
}
