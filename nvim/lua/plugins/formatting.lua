return {
  'stevearc/conform.nvim',
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ lsp_fallback = true })
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
      ["cpp"] = { "clang-format" },
      ["go"] = { "gofmt" },
      ["python"] = { "black" },
      ["php"] = { "php_cs_fixer" },
      ["axaml"] = { "xmllint" },
    },
  },
}
