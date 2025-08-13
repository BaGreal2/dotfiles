return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    enabled = false,
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-space>'] = false,
        ['<C-n>'] = {
          'show',
          'select_next'
        }
      },
      completion = {
        documentation = {
          auto_show = true,
        },
        menu = {
          auto_show = false,
          border = "rounded",
        }
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    version = false,
    config = function()
      require('mini.pairs').setup()
    end,
  }
}
