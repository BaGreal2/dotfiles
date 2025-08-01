return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    cmd = "Telescope",
    init = function()
      if vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
        require("lazy").load({ plugins = { "telescope.nvim" } })
      end
    end,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim', {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    } },
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
      -- {
      --   ";r",
      --   function()
      --     require("telescope.builtin").live_grep()
      --   end,
      --   mode = { "n" }
      -- },
      {
        ";r",
        function()
          require('telescope').extensions.live_grep_args.live_grep_args()
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
          file_ignore_patterns = { "node%_modules/.*", ".DS_Store", ".git/*", "coverage/.*", "dist/", "build/", ".next/" }
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            disable_devicons = true,
            grouped = true,
            preview = {
              hide_on_startup = true
            },
            hijack_netrw = false,
            initial_mode = "normal",
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

      require('telescope').load_extension("live_grep_args")
      require('telescope').load_extension("file_browser")

      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            local dir = vim.fn.fnamemodify(vim.fn.argv(0), ":p")
            vim.cmd("cd " .. vim.fn.fnameescape(dir))
            vim.schedule(function()
              require("telescope.builtin").find_files({
                cwd = dir,
                no_ignore = false,
                hidden = true,
                layout_config = { width = 0.6 },
                preview = { hide_on_startup = true },
              })
            end)
          end
        end,
      })
    end
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
      { "sf", function() require("oil").open() end },
    },
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
      },
    },
  },
  {
    'echasnovski/mini.pick',
    version = false,
    dependencies = { 'echasnovski/mini.extra', 'echasnovski/mini.icons' },
    keys = function()
      local Pick  = require('mini.pick')
      local Extra = require('mini.extra')

      return {
        { ';f',   function() Pick.builtin.files({}) end },
        { ';r',   function() Pick.builtin.grep_live({}) end },
        { '\\\\', function() Pick.builtin.buffers({}) end },
        { ';t',   function() Pick.builtin.help({}) end },
        { ';;',   function() Pick.builtin.resume() end },
        { ';e',   function() Extra.pickers.diagnostic({}) end },
      }
    end,
    config = function()
      require('mini.pick').setup({
        window = {
          config = function()
            local h, w = math.floor(vim.o.lines * 0.7), math.floor(vim.o.columns * 0.7)
            return {
              relative = 'editor',
              width = w,
              height = h,
              row = math.floor((vim.o.lines - h) / 2),
              col = math.floor((vim.o.columns - w) / 2),
              anchor = 'NW',
            }
          end,
        },
        options = {
          content_from_bottom = true,
          use_cache = true
        }
      })
      require('mini.extra').setup()
      require('mini.icons').setup()
    end,
  }
}
