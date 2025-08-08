return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
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
          winhighlight =
          "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }
      },
    },
    opts_extend = { "sources.default" }
  },
}
