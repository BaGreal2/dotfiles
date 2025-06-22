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
        ensure_installed = { "c", "cpp", "lua", "python", "rust", "typescript", "javascript", "tsx", "html", "css", "diff", "markdown", "markdown_inline", "luadoc", "xml" },
        highlight = {
          enable = true,
        },
      })

      vim.treesitter.language.register('xml', 'axaml')
      -- vim.treesitter.language.register('tsx', 'javascript')
    end,
  },
}
