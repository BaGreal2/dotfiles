local tsc_comp_group = vim.api.nvim_create_augroup("tsc_comp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("compiler tsc")
    local project_dir = vim.fn.findfile("tsconfig.json", ".;")
    if project_dir ~= "" then
      local tsconfig_path = vim.fn.fnamemodify(project_dir, ":p")
      vim.opt_local.makeprg = "npx tsc --noEmit --pretty false --project " .. tsconfig_path
    else
      vim.opt_local.makeprg = "npx tsc --noEmit --pretty false"
    end
  end,
  group = tsc_comp_group,
})

local rust_comp_group = vim.api.nvim_create_augroup("rust_comp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- pcall(vim.cmd, "compiler cargo")
    vim.cmd("compiler cargo")

    vim.opt_local.makeprg = "cargo run --color never"

    if vim.bo.efm == "" or vim.bo.efm:match("rust") == nil then
      vim.bo.errorformat = table.concat({
        '%Eerror: %m',
        '%Eerror[%t%*[^]]]: %m',
        '%Wwarning: %m',
        '%Wwarning[%t%*[^]]]: %m',
        '%Inote: %m',
        '%C%*[^-]--> %f:%l:%c',
        '%C%\\s%f:%l:%c',
        '%C%\\s= note: %m',
        '%Z'
      }, ",")
    end
  end,
  group = rust_comp_group,
})
