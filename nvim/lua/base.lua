-- vim.cmd('autocmd!')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.o.relativenumber = true

vim.opt.shortmess:append("I")
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = 'fish'
vim.opt.backupskip = '/tmp/*,/private/tmp/*'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' }
vim.opt.wildignore:append {
  '*/node_modules/*',
  '*/.git/*',
  '*/build/*',
  '*/dist/*',
  '*/out/*',
  '*/.idea/*',
  '*/.vscode/*',
  '*/tmp/*',
  '*/temp/*',
  '*.o',
}

-- MacOS
vim.opt.clipboard:append { 'unnamedplus' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.diagnostic.config {
  float = { border = "rounded" },
  virtual_text = false,
}
