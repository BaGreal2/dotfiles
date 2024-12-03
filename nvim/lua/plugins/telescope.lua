return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    keys = {
      {
        "sf",
        function()
          local function telescope_buffer_dir()
            return vim.fn.expand('%:p:h')
          end

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
        end,
        mode = { "n" }
      },
      {
        ";f",
        function()
          require("telescope.builtin")
              .find_files({
                no_ignore = false,
                hidden = true,
                layout_config = { width = 0.5 },
                preview = {
                  hide_on_startup = true
                }
              })
        end,
        mode = { "n" }
      },
      {
        ";r",
        function()
          require("telescope.builtin").live_grep()
        end,
        mode = { "n" }
      },
      {
        "\\\\",
        function()
          require("telescope.builtin").buffers({
            sort_mru = true,
            sort_lastused = true,
            initial_mode = "normal",
          })
        end,
        mode = { "n" }
      },
      {
        ";t",
        function()
          require("telescope.builtin").help_tags()
        end,
        mode = { "n" }
      },
      {
        ";;",
        function()
          require("telescope.builtin").resume()
        end,
        mode = { "n" }
      },
      {
        ";e",
        function()
          require("telescope.builtin").diagnostics()
        end,
        mode = { "n" }
      }
    },
    config = function()
      local actions = require('telescope.actions')

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
    end
  }
}
