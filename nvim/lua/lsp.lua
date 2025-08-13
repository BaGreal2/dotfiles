vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<A-[>", function() vim.diagnostic.jump({ count = -1, float = true, wrap = true }) end)
vim.keymap.set("n", "<A-]>", function() vim.diagnostic.jump({ count = 1, float = true, wrap = true }) end)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float(nil, { scope = "line" }) end)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>qd', function()
  vim.diagnostic.setqflist({ open = true })
end)

vim.lsp.enable({ "vtsls", "eslint", "efm", "html", "cssls", "tailwindcss", "clangd", "rust_analyzer", "gopls", "pyright",
  "lua_ls" })

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      }
    }
  }
})

local prettier = require("formatters.prettier")

vim.lsp.config('efm', {
  init_options = { documentFormatting = true },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "yaml", "markdown", "html", "css" },
  settings = {
    rootMarkers = {
      ".git/",
      "package.json",
      ".prettierrc",
    },
    languages = {
      typescript = { prettier },
      typescriptreact = { prettier },
      javascript = { prettier },
      javascriptreact = { prettier },
      json = { prettier },
      yaml = { prettier },
      markdown = { prettier },
      html = { prettier },
      css = { prettier },
    },
  },
})

local disable_formatting_clients = {
  vtsls = true,
  html = true,
  cssls = true,
  eslint = true
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if disable_formatting_clients[client.name] then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
