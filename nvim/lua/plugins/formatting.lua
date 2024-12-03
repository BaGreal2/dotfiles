return {
  'stevearc/conform.nvim',
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format()
      end,
      mode = { "x", "n", "v" },
    },
  },
  opts = {
    formatters_by_ft = {
      ["javascript"] = { "prettierd" },
      ["javascriptreact"] = { "prettierd" },
      ["typescript"] = { "prettierd" },
      ["typescriptreact"] = { "prettierd" },
      ["markdown"] = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },
      ["css"] = { "prettierd" },
      ["scss"] = { "prettierd" },
      ["html"] = { "prettierd" },
      ["rust"] = { "rustfmt" },
      ["c"] = { "clang-format" },
      ["cpp"] = { "clang-format" }
    },
    format = {
      timeout_ms = 3000,
      async = true,
      quiet = false,
      lsp_fallback = true,
    },
    -- format_on_save = {
    --   timeout_ms = 3000,
    --   lsp_fallback = true,
    -- }
  },
}
