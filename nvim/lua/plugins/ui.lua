return {
  {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0            -- 0 = just filename, 1 = relative path, 2 = absolute path
          } },
          lualine_x = {
            {
              'diagnostics',
              sources = { "nvim_diagnostic" },
              symbols = {
                error = ' ',
                warn = ' ',
                info = ' ',
                hint = ' '
              }
            },
            'encoding',
            'filetype'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
          } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = { 'fugitive' }
      }
    end

  },
  {
    'akinsho/nvim-bufferline.lua',
    config = function()
      require('bufferline').setup({
        options = {
          mode = "tabs",
          separator_style = 'thin',
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = true
        },
        highlights = {
          separator = {
            fg = '#868A91',
            bg = '#191C21',
          },
          separator_selected = {
            fg = '#ABB2BF',
          },
          background = {
            fg = '#868A91',
            bg = '#191C21'
          },
          buffer_selected = {
            fg = '#ffffff',
            bold = true
          },
          fill = {
            bg = '#191C21'
          }
        },
      })

      vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
      vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
    end
  }
}
