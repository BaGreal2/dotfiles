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
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      require('null-ls').setup({
        sources = {
          require('null-ls').builtins.formatting.prettierd,
          require('null-ls').builtins.diagnostics.fish
        },

        -- For formatting ts/js based on eslint/prettier
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                lsp_formatting(bufnr)
              end,
            })
          end
        end
      })

      vim.api.nvim_create_user_command(
        'DisableLspFormatting',
        function()
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
        end,
        { nargs = 0 }
      )
    end,
  },
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
