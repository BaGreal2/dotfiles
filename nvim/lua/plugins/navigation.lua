return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      { "sf", function() require("oil").open() end },
    },
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      columns = {
        "permissions",
        "size",
        "mtime",
      },
    },
  },
  {
    'echasnovski/mini.pick',
    version = false,
    keys = function()
      local pick = require('mini.pick')
      return {
        { ';f',   function() pick.builtin.files({}) end },
        { ';r',   function() pick.builtin.grep_live({}) end },
        { '\\\\', function() pick.builtin.buffers({}) end },
        { ';;',   function() pick.builtin.resume() end },
      }
    end,
    config = function()
      require('mini.pick').setup({
        options = {
          use_cache = true
        },
        source = {
          show = require('mini.pick').default_show,
        },
      })
    end,
  }
}
