return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      local builtin = require("telescope.builtin")

      local function telescope_buffer_dir()
        return vim.fn.expand('%:p:h')
      end

      local fb_actions = require "telescope".extensions.file_browser.actions

      require('telescope').setup {
        defaults = {
          disable_devicons = true,
          mappings = {
            n = {
              ["q"] = actions.close,
              ["d"] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = { "node%_modules/.*", ".DS_Store", ".git/*", "coverage/.*" }
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            disable_devicons = true,
            grouped = true,
            preview = {
              hide_on_startup = true
            },
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            layout_config = {
              height = 40,
              width = 0.5
            },
            mappings = {
              -- your custom insert mode mappings
              ["i"] = {
                ["<C-w>"] = function() vim.cmd('normal vbd') end,
              },
              ["n"] = {
                -- your custom normal mode mappings
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["d"] = fb_actions.remove,
                ["m"] = fb_actions.toggle_hidden,
                ["/"] = function()
                  vim.cmd('startinsert')
                end
              },
            },
          },
        },
      }

      require('telescope').load_extension("file_browser")

      vim.keymap.set("n", "sf", function()
        require('telescope').extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          disable_devicons = true,
          layout_config = { height = 40 }
        })
      end)

      -- keymaps
      vim.keymap.set('n', ';f',
        function()
          builtin.find_files({
            no_ignore = false,
            hidden = true,
            layout_config = { width = 0.5 },
            preview = {
              hide_on_startup = true
            }
          })
        end)
      vim.keymap.set('n', ';r', function()
        builtin.live_grep()
      end)
      vim.keymap.set('n', '\\\\', function()
        builtin.buffers({
          sort_mru = true,
          sort_lastused = true,
          initial_mode = "normal",
        })
      end)
      vim.keymap.set('n', ';t', function()
        builtin.help_tags()
      end)
      vim.keymap.set('n', ';;', function()
        builtin.resume()
      end)
      vim.keymap.set('n', ';e', function()
        builtin.diagnostics()
      end)
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
}
