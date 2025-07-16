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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = { 'yioneko/nvim-vtsls' },
    config = function()
      local on_attach_maps = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
        vim.keymap.set('n', '<A-[>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
        vim.keymap.set('n', '<A-]>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
        vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
        vim.keymap.set('n', 'gl', '<Cmd>lua vim.diagnostic.open_float(0, { scope="line"})<CR>', opts)
        vim.keymap.set('n', 'gp', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
      end

      -- local on_attach = function(client, bufnr)
      --   on_attach_maps(bufnr)
      --   client.server_capabilities.semanticTokensProvider = nil
      --
      --   -- format on save
      --   if client.server_capabilities.documentFormattingProvider then
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = vim.api.nvim_create_augroup("Format", { clear = true }),
      --       buffer = bufnr,
      --       callback = function() vim.lsp.buf.format() end
      --     })
      --   end
      -- end

      local on_attach_csharp = function(client, bufnr)
        on_attach_maps(bufnr)
        client.server_capabilities.semanticTokensProvider = nil

        -- format on save for csharp (sync, without check)
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end
        })
      end

      -- disable semantic tokens for typescript
      local on_attach_no_highlight = function(client, bufnr)
        on_attach_maps(bufnr)
        client.server_capabilities.semanticTokensProvider = nil
      end

      --Enable (broadcasting) snippet capability for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- TypeScript
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      require('lspconfig').vtsls.setup {
        on_attach = on_attach_no_highlight,
      }
      require('lspconfig').eslint.setup {
        settings = {
          format = false
        }
      }

      -- HTML
      require('lspconfig').html.setup {
        on_attach = on_attach_no_highlight,
        embeddedLanguages = {
          css = true,
          javascript = false
        },
        capabilities = capabilities,
        filetypes = { "html" }
      }

      -- CSS
      require('lspconfig').cssls.setup {
        on_attach = on_attach_no_highlight,
        capabilities = capabilities
      }
      require('lspconfig').tailwindcss.setup {}

      -- C++
      require('lspconfig').clangd.setup {
        on_attach = on_attach_no_highlight,
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = { "clangd", "--offset-encoding=utf-16" }
      }

      -- C#
      require('lspconfig').csharp_ls.setup {
        on_attach = on_attach_no_highlight,
      }

      -- Rust
      require('lspconfig').rust_analyzer.setup {
        on_attach = on_attach_no_highlight,
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
        on_attach = on_attach_no_highlight,
      }

      -- Python
      require('lspconfig').pyright.setup {
        on_attach = on_attach_no_highlight,
      }

      -- LUA
      require('lspconfig').lua_ls.setup {
        on_attach = on_attach_no_highlight,
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
        on_attach = on_attach_no_highlight,
      }

      -- SQL
      require('lspconfig').sqlls.setup {
        on_attach = on_attach_no_highlight,
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
