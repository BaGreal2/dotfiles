return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    lazy = false,
    priority = 1000,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "lua", "python", "rust", "typescript", "javascript", "tsx", "html", "css", "diff", "markdown", "markdown_inline", "luadoc" },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
