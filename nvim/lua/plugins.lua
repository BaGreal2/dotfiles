local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status, lazy = pcall(require, 'lazy')
if (not status) then return end


lazy.setup({
  'p00f/alabaster.nvim',

  'glepnir/lspsaga.nvim',

  'hoob3rt/lualine.nvim',
  'onsails/lspkind-nvim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',
  'yioneko/nvim-vtsls',

  'jose-elias-alvarez/null-ls.nvim',

  'windwp/nvim-autopairs',

  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',

  'akinsho/nvim-bufferline.lua',
  'norcalli/nvim-colorizer.lua',

  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim',

  'numToStr/Comment.nvim',

  'numToStr/FTerm.nvim',

  'zbirenbaum/copilot.lua',

  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    ft = { 'markdown' }
  },

  checker = {
    enabled = true
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
