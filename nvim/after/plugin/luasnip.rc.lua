local status, ls = pcall(require, "luasnip")
if (not status) then return end

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("typescript", {
  s("clg", {
    t("console.log("), i(1, "msg"), t(");")
  })
})
ls.add_snippets("javascript", {
  s("clg", {
    t("console.log("), i(1, "msg"), t(");")
  })
})
ls.add_snippets("typescriptreact", {
  s("clg", {
    t("console.log("), i(1, "msg"), t(");")
  })
})
ls.add_snippets("javascriptreact", {
  s("clg", {
    t("console.log("), i(1, "msg"), t(");")
  })
})

ls.add_snippets("c", {
  s("clg", {
    t("printf(\""), i(1, "msg"), t("\");")
  })
})
