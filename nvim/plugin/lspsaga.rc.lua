local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup({
  ui = {
    winblend = 0,
    border = 'rounded',
  },
  finder_action_keys = {
    open = 'o', vsplit = 's', split = 'i', tabe = 't', quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  symbol_in_winbar = {
    enable = false
  },
  lightbulb = {
    enable = false
  },
  outline = {
    layout = 'float'
  }
})

local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- vim.keymap.set('n', 'gl', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', 'gl', '<Cmd>lua vim.diagnostic.open_float(0, { scope="line"})<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
-- local codeaction = require("lspsaga.codeaction")
-- vim.keymap.set("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
-- vim.keymap.set("v", "<leader>ca", function()
--   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
--   codeaction:range_code_action()
-- end, { silent = true })
