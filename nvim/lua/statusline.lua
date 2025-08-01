local function diag_segment()
  local b     = vim.api.nvim_get_current_buf()
  local parts = {}

  local function add(sev, hl, icon)
    local n = #vim.diagnostic.get(b, { severity = sev })
    if n > 0 then
      parts[#parts + 1] = hl .. icon .. n .. "%*" -- no extra spaces
    end
  end

  add(vim.diagnostic.severity.ERROR, "%#DiagnosticError#", "E")
  add(vim.diagnostic.severity.WARN, "%#DiagnosticWarn#", "W")
  add(vim.diagnostic.severity.INFO, "%#DiagnosticInfo#", "I")
  add(vim.diagnostic.severity.HINT, "%#DiagnosticHint#", "H")

  return table.concat(parts, " ") -- exactly one space between chunks
end

local function git_segment()
  local gs = vim.b.gitsigns_status_dict
  if not gs or not gs.head or gs.head == "" then return "" end
  return string.format("  %s +%d ~%d -%d", gs.head, gs.added or 0, gs.changed or 0, gs.removed or 0)
end

_G.MyStl         = function()
  return table.concat({
    " %f", " %m%r%h%w",
    "%=",
    diag_segment(),
    "  %#StGit#", git_segment(), "%*",
    "  %y  %l:%c ",
  })
end

vim.o.statusline = "%!v:lua.MyStl()"
vim.api.nvim_create_autocmd("DiagnosticChanged", { callback = function() vim.cmd.redrawstatus() end })
