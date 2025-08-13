return {
  {
    'stevearc/oil.nvim',
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            require("lazy").load({ plugins = { "oil.nvim" } })
            require("oil").open(vim.fn.argv(0))
          end
        end,
      })
    end,
    keys = {
      { "-", function() require("oil").open() end },
    },
    opts = {
      keymaps = {
        ["gx"] = "actions.open_cmdline",
        ["go"] = "actions.open_external",
      },
      skip_confirm_for_simple_edits = true,
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
    keys = {
      { ';f',   function() require('mini.pick').builtin.files() end },
      { ';r',   function() require('mini.pick').builtin.grep_live() end },
      { ';t',   function() require('mini.pick').builtin.help() end },
      { '\\\\', function() require('mini.pick').builtin.buffers() end },
      { ';;',   function() require('mini.pick').builtin.resume() end },
    },
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
