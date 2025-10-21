return {
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      { "-", function() require("oil").open() end },
    },
    opts = {
      keymaps = {
        ["gx"] = "actions.open_cmdline",
        ["go"] = "actions.open_external",
      },
      skip_confirm_for_simple_edits = true,
      columns = {
        "permissions",
        "size",
        "mtime",
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { ';f',   function() require('telescope.builtin').find_files() end },
      { ';r',   function() require('telescope.builtin').live_grep() end },
      { ';t',   function() require('telescope.builtin').help_tags() end },
      { '\\\\', function() require('telescope.builtin').buffers() end },
      { ';;',   function() require('telescope.builtin').resume() end },
    },
    config = function()
      local actions = require('telescope.actions')
      local actions_layout = require('telescope.actions.layout')

      require('telescope').setup({
        defaults = {
          mappings = {
            n = {
              ["d"] = actions.delete_buffer,
              ["<A-p>"] = actions_layout.toggle_preview
            },
            i = {
              ["<A-p>"] = actions_layout.toggle_preview
            },
          },
        },
        pickers = {
          find_files = {
            previewer = false,
            theme = "ivy"
          },
          buffers = {
            previewer = false,
            sort_mru = true,
            sort_lastused = true,
            initial_mode = "normal",
            theme = "ivy"
          },
          live_grep = {
            previewer = false,
            theme = "ivy"
          },
          help_tags = {
            theme = "ivy"
          },
        },
      })
    end,
  },
}
