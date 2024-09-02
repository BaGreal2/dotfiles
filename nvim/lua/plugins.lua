local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status, lazy = pcall(require, 'lazy')
if (not status) then return end


lazy.setup({
  --{
  --  'svrana/neosolarized.nvim',
  --  dependencies = { 'tjdevries/colorbuddy.nvim' }
  --},
  -- { 'rose-pine/neovim', name = 'rose-pine' },
  -- 'navarasu/onedark.nvim',
  'rebelot/kanagawa.nvim',

  'kyazdani42/nvim-web-devicons',
  'glepnir/lspsaga.nvim',

  -- snippets
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  'hoob3rt/lualine.nvim',
  'onsails/lspkind-nvim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  'jose-elias-alvarez/null-ls.nvim',
  'MunifTanjim/prettier.nvim',

  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-file-browser.nvim',

  'akinsho/nvim-bufferline.lua',
  'norcalli/nvim-colorizer.lua',

  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim',

  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',

  'numToStr/FTerm.nvim',

  'zbirenbaum/copilot.lua',

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = true
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown'
  },

  checker = {
    enabled = true -- automatically check for plugin updates
  },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
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
