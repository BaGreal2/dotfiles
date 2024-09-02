local status, n = pcall(require, 'onedark')
if (not status) then return end

-- local links = {
--   ['@lsp.type.namespace'] = '@namespace',
--   ['@lsp.type.type'] = '@type',
--   ['@lsp.type.class'] = '@type',
--   ['@lsp.type.enum'] = '@type',
--   ['@lsp.type.interface'] = '@type',
--   ['@lsp.type.struct'] = '@structure',
--   ['@lsp.type.parameter'] = '@parameter',
--   ['@lsp.type.variable'] = '@variable',
--   ['@lsp.type.property'] = '@property',
--   ['@lsp.type.enumMember'] = '@constant',
--   ['@lsp.type.function'] = '@function',
--   ['@lsp.type.method'] = '@method',
--   ['@lsp.type.macro'] = '@macro',
--   ['@lsp.type.decorator'] = '@function',
-- }
-- for newgroup, oldgroup in pairs(links) do
--   vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
-- end

n.setup {
  style = 'darker',
  transparent = true,
  highlights = {
    ["@constant"] = { fg = '#C89266' },
    ["@constant.macro"] = { fg = '#C89266' },
    ["@constant.builtin"] = { fg = '#C89266' },

    ['@tag'] = { fg = '$red' },
    ['@tag.delimiter'] = { fg = '$fg' },

    ['@property'] = { fg = '$red' },
    ['@lsp.type.property'] = { fg = '$red' },

    ['@parameter'] = { fg = '$fg' },
    ['@lsp.type.parameter'] = { fg = '$fg' },
    -- ['@lsp.type.class'] = { fg = '$yellow' },
    ['@constructor'] = { fmt = 'none' },
  },
  diagnostics = {
    undercurl = true, -- use undercurl instead of underline for diagnostics
  },
}

n.load()
