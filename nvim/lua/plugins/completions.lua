return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspkind = require 'lspkind'

      require('cmp').setup({
        completion = {
          autocomplete = false,
        },
        mapping = require('cmp').mapping.preset.insert({
          ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
          ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
          ['<C-Space>'] = require('cmp').mapping.complete(),
          ['<C-e>'] = require('cmp').mapping.close(),
          ['<CR>'] = require('cmp').mapping.confirm({
            behavior = require('cmp').ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = require('cmp').config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
          }),
        },
        window = {
          completion = require('cmp').config.window.bordered(),
          documentation = require('cmp').config.window.bordered(),
        },
      })

      vim.cmd [[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
      ]]
    end,
  },
  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   event = 'BufReadPre',
  --   config = function()
  --     require('null-ls').setup({
  --       sources = {
  --         -- require('null-ls').builtins.formatting.prettierd,
  --         -- require('null-ls').builtins.diagnostics.fish
  --       }
  --     })
  --   end,
  -- },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = 'mm',
          block = 'MM'
        },
        opleader = {
          line = 'mm',
          block = 'MM',
        },
      })
    end,
  }
}
