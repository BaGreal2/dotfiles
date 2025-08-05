vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<A-[>", function() vim.diagnostic.jump({ count = -1, float = true, wrap = true }) end)
vim.keymap.set("n", "<A-]>", function() vim.diagnostic.jump({ count = 1, float = true, wrap = true }) end)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gl", function() vim.diagnostic.open_float(nil, { scope = "line" }) end)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)

vim.lsp.enable({ "vtsls", "html", "cssls", "clangd", "rust_analyzer", "gopls", "pyright", "lua_ls" })

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      }
    }
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
