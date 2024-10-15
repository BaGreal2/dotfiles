vim.api.nvim_create_user_command('Esfix', function()
  local file = vim.fn.expand('%:p')
  print("Formatted current file.")
  vim.cmd("silent! !eslint_d --fix " .. file)
end, {})

-- Compilation "mode"
_G.compile_cmd = ""

-- Set compile command
vim.api.nvim_create_user_command('SetCompileCommand', function(args)
  _G.compile_cmd = args.args
  print("Compile command set to: " .. _G.compile_cmd)
end, { nargs = 1 }) -- The "nargs = 1" makes sure one argument is passed

-- Run the compile command
vim.api.nvim_create_user_command('Compile', function()
  if _G.compile_cmd == "" then
    print("No compile command set. Use :SetCompileCommand to set one.")
  else
    vim.cmd("split | resize 10 | term " .. _G.compile_cmd)
    vim.cmd("startinsert!")
    vim.api.nvim_command('normal! G')
  end
end, {})
