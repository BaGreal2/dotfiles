local status, packer = pcall(require, 'packer')
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  --use {
  --  'svrana/neosolarized.nvim',
  --  requires = { 'tjdevries/colorbuddy.nvim' }
  --}
  use { 'rose-pine/neovim', as = 'rose-pine' }
  -- use 'navarasu/onedark.nvim'


  use 'kyazdani42/nvim-web-devicons'
  use 'glepnir/lspsaga.nvim'

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use { 'saadparwaiz1/cmp_luasnip' }
  use 'rafamadriz/friendly-snippets'

  use 'hoob3rt/lualine.nvim'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- use 'mrjones2014/nvim-ts-rainbow'

  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'akinsho/nvim-bufferline.lua'
  use 'norcalli/nvim-colorizer.lua'

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim'

  use 'numToStr/Comment.nvim'

  use "numToStr/FTerm.nvim"

  -- Markdown
  use { "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
end)
