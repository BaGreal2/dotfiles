vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shortmess:append("I")
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'fish'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' }
vim.opt.wildignore:append {
  '*/node_modules/*',
  '*/.git/*',
  '*/.idea/*',
  '*/.vscode/*',
  '*/.next/*',
  '*/build/*',
  '*/dist/*',
  '*/out/*',
  '*/tmp/*',
  '*/temp/*',
  '*.o',
}
vim.o.grepprg = "rg --vimgrep --hidden --smart-case --glob '!.git/**' --glob '!node_modules/**' --glob '!.next/**'"

-- MacOS
vim.opt.clipboard:append { 'unnamedplus' }
