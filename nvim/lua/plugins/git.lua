return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup()
      vim.keymap.set('n', '<leader>gb', '<Cmd>Gitsigns blame_line<CR>', {})
    end
  },
  {
    'tpope/vim-fugitive',
    cmd = {
      'Git', 'G',
      'Gdiffsplit', 'Gvdiffsplit',
      'Gread', 'Gwrite', 'Gclog'
    },
    keys = {
      { '<leader>gd', ':Gvdiffsplit!<CR>' },
      { '<leader>dh', ':diffget //2<CR>' },
      { '<leader>dl', ':diffget //3<CR>' },
      { '<leader>gl', ':Gclog<CR>' },
      { '<leader>gb', ':G blame<CR>' },
      { '<leader>gf', ':G fetch<CR>' },
      { '<leader>gc', ':G checkout ' },
      { '<leader>gp', ':G push<CR>' },
      { '<leader>gP', ':G pull<CR>' },
    },
  },
}
