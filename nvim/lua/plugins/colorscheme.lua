return {
  {
    'p00f/alabaster.nvim',
    config = function()
      -- vim.g.alabaster_dim_comments = true
      vim.cmd('colorscheme alabaster')

      vim.api.nvim_set_hl(0, "Normal", { bg = nil })
      vim.api.nvim_set_hl(0, "NonText", { bg = nil })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#202020" })
    end,
  }
}
