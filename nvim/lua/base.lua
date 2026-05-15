vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert" }
vim.opt.shortmess:append("I")
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.expandtab = true
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.path:append { "src/**", "include/**", "app/**", "public/**", "packages", "packages/*/src/**", "apps", "apps/*/src/**", "apps/*/public/**", "lib/**", "config/**", "test/**" }
vim.opt.wildignore:append { '*/node_modules/*', '*/.git/*', '*/.next/*', '*/build/*', '*/dist/*', '*/out/*', '*/tmp/*', '*/temp/*', '*.o' }
vim.o.grepprg = "rg --vimgrep --hidden --smart-case --glob '!.git/**' --glob '!node_modules/**' --glob '!.next/**'"

require("vim._core.ui2").enable({})

local mark_ns = vim.api.nvim_create_namespace("user_marks")

vim.api.nvim_create_autocmd({ "BufEnter", "MarkSet" }, {
  desc = "Show user marks in the sign column",
  callback = function(args)
    vim.api.nvim_buf_clear_namespace(args.buf, mark_ns, 0, -1)

    local marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i = 1, #marks do
      local m = marks:sub(i, i)
      local pos = vim.api.nvim_buf_get_mark(args.buf, m)
      local lnum = pos[1]

      if lnum > 0 then
        pcall(vim.api.nvim_buf_set_extmark, args.buf, mark_ns, lnum - 1, 0, {
          sign_text = m,
          sign_hl_group = "DiagnosticHint",
        })
      end
    end
  end,
})
