return {
  -- {
  --   'p00f/alabaster.nvim',
  --   config = function()
  --     -- vim.g.alabaster_dim_comments = true
  --     vim.cmd('colorscheme alabaster')
  --
  --     vim.api.nvim_set_hl(0, "Normal", { bg = nil })
  --     vim.api.nvim_set_hl(0, "NonText", { bg = nil })
  --     vim.api.nvim_set_hl(0, "CursorLine", { bg = "#202020" })
  --   end,
  -- },
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        compile = true,
        transparent = true,
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        terminalColors = true,
        background = {
          dark = "wave",
        },
      })

      vim.cmd('colorscheme kanagawa')

      vim.api.nvim_set_hl(0, "Normal", { bg = '' })
      vim.api.nvim_set_hl(0, "NonText", { bg = '' })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#202020" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = '', fg = '#54546d' })

      -- Diagnostcs
      vim.api.nvim_set_hl(0, 'DiagnosticSignError', { bg = '', fg = "#e82424" })
      vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { bg = '', fg = '#ff9d3c' })
      vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { bg = '', fg = '#6a9588' })
      -- vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { bg = '' })

      -- Line numbers
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#54546d', bg = '' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#ff9e3b", bold = true, bg = '' })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#54546d', bg = '' })

      -- Git Signs
      vim.api.nvim_set_hl(0, 'SignColumn', { fg = "#938aa9", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = "#76946a", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = "#76946a", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = "#dca561", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = "#dca561", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = "#c34043", bg = '' })
      vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = "#c34043", bg = '' })
    end,
  }
}
