vim.cmd("compiler tsc")

local project_dir = vim.fn.findfile("tsconfig.json", ".;")

if project_dir ~= "" then
  local tsconfig_path = vim.fn.fnamemodify(project_dir, ":p")
  vim.opt_local.makeprg = "npx tsc --noEmit --pretty false --project " .. tsconfig_path
else
  vim.opt_local.makeprg = "npx tsc --noEmit --pretty false"
end
