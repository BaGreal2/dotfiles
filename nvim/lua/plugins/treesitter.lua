return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "BufReadPost" },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "lua", "python", "rust", "typescript", "javascript", "tsx", "html", "css", "diff", "markdown", "markdown_inline", "luadoc" },
        highlight = {
          enable = false,
        },
        indent = {
          enable = true
        }
      })
    end,
  },
}
