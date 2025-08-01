return {
  {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    enabled = false,
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
    end
  },
  {
    'onsails/lspkind-nvim',
    enabled = false,
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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = { 'yioneko/nvim-vtsls' },
    config = function()
      local on_attach_maps = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "K", vim.lsp.buf.hover)
        map("n", "<A-[>", function() vim.diagnostic.jump({ count = -1, float = true, wrap = true }) end)
        map("n", "<A-]>", function() vim.diagnostic.jump({ count = 1, float = true, wrap = true }) end)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gl", function() vim.diagnostic.open_float(nil, { scope = "line" }) end)
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
      end

      local on_lsp_attach = function(client, bufnr)
        on_attach_maps(bufnr)
        client.server_capabilities.semanticTokensProvider = nil
      end

      --Enable (broadcasting) snippet capability for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- TypeScript
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      require('lspconfig').vtsls.setup {
        on_attach = on_lsp_attach,
      }
      require('lspconfig').eslint.setup {
        settings = {
          format = false
        }
      }

      -- HTML
      require('lspconfig').html.setup {
        on_attach = on_lsp_attach,
        embeddedLanguages = {
          css = true,
          javascript = false
        },
        capabilities = capabilities,
        filetypes = { "html" }
      }

      -- CSS
      require('lspconfig').cssls.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities
      }
      require('lspconfig').tailwindcss.setup {}

      -- C++
      require('lspconfig').clangd.setup {
        on_attach = on_lsp_attach,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = { "clangd", "--offset-encoding=utf-16" }
      }

      -- C#
      require('lspconfig').csharp_ls.setup {
        on_attach = on_lsp_attach,
      }

      -- Rust
      require('lspconfig').rust_analyzer.setup {
        on_attach = on_lsp_attach,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
            }
          }
        },
        cmd = { "rust-analyzer" }
      }

      require('lspconfig').gopls.setup {
        on_attach = on_lsp_attach,
      }

      -- Python
      require('lspconfig').pyright.setup {
        on_attach = on_lsp_attach,
      }

      -- LUA
      require('lspconfig').lua_ls.setup {
        on_attach = on_lsp_attach,
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

      require('lspconfig').phpactor.setup {
        on_attach = on_lsp_attach,
      }

      -- SQL
      require('lspconfig').sqlls.setup {
        on_attach = on_lsp_attach,
      }

      -- Markdown
      -- require('lspconfig').marksman.setup {
      --   on_attach = on_attach_no_highlight,
      -- }
    end
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- }
}
