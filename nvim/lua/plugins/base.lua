return {
  {
    'numToStr/FTerm.nvim',
    cmd = 'FTermToggle',
    config = function()
      require('FTerm').setup({
        border = 'rounded',
        dimensions = {
          height = 0.8,
          width = 0.8,
        },
      })

      vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      local on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            vim.cmd("Copilot")
          end,
        })
      end

      require('copilot').setup({
        on_attach = on_attach,
        suggestion = {
          auto_trigger = true,
          hide_during_completion = false
        }
      })
    end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    ft = { 'markdown' },
    config = function()
      require('render-markdown').setup({})
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ '*' })
    end
  },

  checker = {
    enabled = true
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "2html_plugin",
        "tutor",
        "zipPlugin",
        "logiPat",
        "spellfile_plugin",
        "tutor_mode_plugin",
      },
    },
  },
}
