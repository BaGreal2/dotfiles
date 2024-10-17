return {
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({
        ui = {
          winblend = 0,
          border = 'rounded',
        },
        finder_action_keys = {
          open = 'o',
          vsplit = 's',
          split = 'i',
          tabe = 't',
          quit = 'q',
          scroll_down = '<C-f>',
          scroll_up =
          '<C-b>' -- quit can be a table
        },
        symbol_in_winbar = {
          enable = false
        },
        lightbulb = {
          enable = false
        },
        outline = {
          layout = 'float'
        }
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
      vim.keymap.set('n', 'gl', '<Cmd>lua vim.diagnostic.open_float(0, { scope="line"})<CR>', opts)
      vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
      vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
      vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
      vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

      -- code action
      vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    end
  },
  {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init({
        mode = 'symbol_text',
        preset = 'codicons',
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "󰙅",
          Event = "",
          Operator = "",
          TypeParameter = ""
        },
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'yioneko/nvim-vtsls' },
    config = function()
      local on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        -- format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.format() end
          })
        end
      end

      local on_attach_csharp = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        -- format on save for csharp (sync, without check)
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end
        })
      end

      -- disable semantic tokens for typescript
      local on_attach_ts = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
      end

      --Enable (broadcasting) snippet capability for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- TypeScript
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      require('lspconfig').vtsls.setup {
        on_attach = on_attach_ts,
      }
      require('lspconfig').eslint.setup {
        settings = {
          format = false
        }
      }

      -- HTML
      require('lspconfig').html.setup {
        on_attach = on_attach,
        embeddedLanguages = {
          css = true,
          javascript = false
        },
        capabilities = capabilities,
        filetypes = { "html" }
      }

      -- CSS
      require('lspconfig').cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities
      }
      require('lspconfig').tailwindcss.setup {}

      -- C++
      require('lspconfig').clangd.setup {
        on_attach = on_attach,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = { "clangd", "--offset-encoding=utf-16" }
      }

      -- C#
      require('lspconfig').csharp_ls.setup {
        on_attach = on_attach_csharp,
      }

      -- Rust
      require('lspconfig').rust_analyzer.setup {
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
            }
          }
        },
        cmd = { "rust-analyzer" }
      }

      -- Python
      require('lspconfig').pyright.setup {
        on_attach = on_attach,
      }

      -- LUA
      require('lspconfig').lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            }
          }
        }
      }

      -- SQL
      require('lspconfig').sqlls.setup {
        on_attach = on_attach,
      }

      -- Markdown
      require('lspconfig').marksman.setup {
        on_attach = on_attach
      }
    end
  },
}
