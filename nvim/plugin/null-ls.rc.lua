local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local path_to_disable = "/Users/macbook/Developer/Work/Vektor/vektor-dashboard-frontend"

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d.with({
      virtual_text = false,
      diagnostics_format = '[eslint] #{m}\n(#{c})',
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" })
      end,
    }),
    null_ls.builtins.diagnostics.fish
  },

  -- For formatting ts/js based on eslint/prettier
  on_attach = function(client, bufnr)
    local current_file = vim.fn.expand("%:p")
    if client.supports_method("textDocument/formatting") and not current_file:find(path_to_disable, 1, true) then
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
