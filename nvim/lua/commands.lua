vim.api.nvim_create_user_command('Esfix', function()
  local file = vim.fn.expand('%:p')
  print("Formatted current file.")
  vim.cmd("silent! !eslint_d --fix " .. file)
end, {})

----------- Compilation "mode" -----------
_G.compile_cmd = ""

local compile_commands = {
  ["%.c$"] = "make && ./main",
  ["%.cs$"] = "dotnet run",
  ["%.tsx$"] = "npx tsc --noEmit",
  ["%.py$"] = "python3 ./%.py",
  ["%.js$"] = "node ./%.js",
  ["%.ts$"] = "ts-node ./%.ts",
  ["%.rs$"] = "cargo run"
}

local function set_compile_command_by_filename()
  local filename = vim.fn.expand("%:t")
  _G.compile_cmd = ""

  for pattern, command in pairs(compile_commands) do
    if filename:match(pattern) then
      _G.compile_cmd = command
      -- print("Auto compile command set to: " .. _G.compile_cmd)
      return
    end
  end
end

vim.api.nvim_create_user_command('SetCompileCommand', function(args)
  _G.compile_cmd = args.args
  print("Compile command set to: " .. _G.compile_cmd)
end, { nargs = 1 })

vim.api.nvim_create_user_command('Compile', function()
  if _G.compile_cmd == "" then
    print("No compile command set. Use :SetCompileCommand to set one.")
  else
    vim.cmd("split | resize 10 | term " .. _G.compile_cmd)
    vim.api.nvim_command('normal! G')
  end
end, {})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_compile_command_by_filename
})

----------- Toggle window layout -----------

vim.g.maximized_window = 0

function ToggleMaximize()
  if vim.g.maximized_window == 0 then
    vim.cmd('wincmd _')
    vim.cmd('wincmd |')
    vim.g.maximized_window = 1
  else
    local windows = vim.fn.getwininfo()
    if #windows > 1 then
      vim.cmd('wincmd =')
    end
    vim.g.maximized_window = 0
  end
end

vim.api.nvim_set_keymap('n', '<Leader>w', ':lua ToggleMaximize()<CR>', { noremap = true, silent = true })
