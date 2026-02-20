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

if vim.g.neovide then
  vim.o.guifont = "IosevkaTerm NFM:h16"
  vim.g.background = "#121212"
  vim.g.neovide_background_color = "#121212"
  vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
end
