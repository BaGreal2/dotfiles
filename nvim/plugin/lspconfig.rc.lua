local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format { async = true } end
    })
  end
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- TypeScript
nvim_lsp.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  cmd = { "typescript-language-server", "--stdio" }
}

-- HTML
nvim_lsp.html.setup {
  on_attach = on_attach,
  embeddedLanguages = {
    css = true,
    javascript = false
  },
  capabilities = capabilities,
  filetypes = { "html" }
}

-- CSS
nvim_lsp.cssmodules_ls.setup {
  on_attach = on_attach,
}
nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
nvim_lsp.tailwindcss.setup {}

-- C++
nvim_lsp.clangd.setup {
  on_attach = on_attach,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  cmd = { "clangd", "--offset-encoding=utf-16" }
}

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
}

-- nvim_lsp.pylsp.setup {
--   on_attach = on_attach,
--   filetypes = { "python" },
--   cmd = { "pylsp" },
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = { 'W391' },
--           maxLineLength = 140
--         }
--       }
--     }
--   }
-- }
nvim_lsp.pyright.setup {
  on_attach = on_attach,
}

nvim_lsp.lua_ls.setup {
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

nvim_lsp.sqlls.setup {
  on_attach = on_attach,
}

-- Markdown
nvim_lsp.marksman.setup {
  on_attach = on_attach
}
