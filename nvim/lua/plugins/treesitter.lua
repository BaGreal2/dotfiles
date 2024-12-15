return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "cpp", "lua", "python", "rust", "typescript", "javascript", "tsx", "html", "css", "diff", "markdown" },
        highlight = {
          enable = false,
        }
      })
    end,
  },
}
