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
      'Gread', 'Gwrite'
    },
    keys = {
      { '<leader>gm',  ':Gvdiffsplit!<CR>' },
      { '<leader>gh2', ':diffget //2<CR>' },
      { '<leader>gh3', ':diffget //3<CR>' },
    },
  },
}
