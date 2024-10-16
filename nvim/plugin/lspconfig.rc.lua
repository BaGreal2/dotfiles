local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

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

nvim_lsp.vtsls.setup {
  on_attach = on_attach_ts,
}
nvim_lsp.eslint.setup {
  settings = {
    format = false
  }
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

-- C#
nvim_lsp.csharp_ls.setup {
  on_attach = on_attach_csharp,
}

-- Rust
nvim_lsp.rust_analyzer.setup {
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
nvim_lsp.pyright.setup {
  on_attach = on_attach,
}

-- LUA
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

-- SQL
nvim_lsp.sqlls.setup {
  on_attach = on_attach,
}

-- Markdown
nvim_lsp.marksman.setup {
  on_attach = on_attach
}
