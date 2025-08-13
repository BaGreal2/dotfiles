local ns = vim.api.nvim_create_namespace("ColorPreview")
local state = { win = nil, buf = nil, map_buf = nil }

local function clamp(x, a, b) return math.max(a, math.min(b, x)) end

local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", clamp(r, 0, 255), clamp(g, 0, 255), clamp(b, 0, 255))
end

local function hsl_to_rgb(h, s, l)
  h = ((h % 360) + 360) % 360; s = clamp(s, 0, 1); l = clamp(l, 0, 1)
  local c = (1 - math.abs(2 * l - 1)) * s
  local x = c * (1 - math.abs((h / 60) % 2 - 1))
  local m = l - c / 2
  local r, g, b = 0, 0, 0
  if h < 60 then
    r, g, b = c, x, 0
  elseif h < 120 then
    r, g, b = x, c, 0
  elseif h < 180 then
    r, g, b = 0, c, x
  elseif h < 240 then
    r, g, b = 0, x, c
  elseif h < 300 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end
  return math.floor((r + m) * 255 + 0.5), math.floor((g + m) * 255 + 0.5), math.floor((b + m) * 255 + 0.5)
end

local function parse_color(str)
  str = str:lower()
  local hex = str:match("#%x%x%x%x%x%x%x%x") or str:match("#%x%x%x%x%x%x") or str:match("#%x%x%x%x") or
      str:match("#%x%x%x")
  if hex then
    if #hex == 4 then
      local r, g, b = hex:sub(2, 2), hex:sub(3, 3), hex:sub(4, 4)
      return "#" .. r .. r .. g .. g .. b .. b
    elseif #hex == 5 then
      local r, g, b = hex:sub(2, 2), hex:sub(3, 3), hex:sub(4, 4)
      return "#" .. r .. r .. g .. g .. b .. b
    elseif #hex == 9 then
      return hex:sub(1, 7)
    else
      return hex
    end
  end
  local r, g, b = str:match("rgba?%s*%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
  if r and g and b then return rgb_to_hex(tonumber(r), tonumber(g), tonumber(b)) end
  local H, S, L = str:match("hsla?%s*%(%s*([%d%.]+)%s*[, ]%s*([%d%.]+)%%%s*[, ]%s*([%d%.]+)%%")
  if H and S and L then
    local rr, gg, bb = hsl_to_rgb(tonumber(H), tonumber(S) / 100, tonumber(L) / 100)
    return rgb_to_hex(rr, gg, bb)
  end
  return nil
end

local function color_under_cursor()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then return nil end
  local patterns = { "#[%x_%-%.%a%d]+", "rgba?%s*%b()", "hsla?%s*%b()" }
  local hits = {}
  for _, pat in ipairs(patterns) do
    local i = 1
    while true do
      local s, e = string.find(line, pat, i)
      if not s then break end
      table.insert(hits, { s = s, e = e })
      i = e + 1
    end
  end
  for _, h in ipairs(hits) do
    if col + 1 >= h.s and col + 1 <= h.e then
      local token = line:sub(h.s, h.e)
      token = token:match("#%x%x%x%x%x%x%x%x") or
          token:match("#%x%x%x%x%x%x") or
          token:match("#%x%x%x%x") or
          token:match("#%x%x%x") or
          token:match("rgba?%s*%b()") or
          token:match("hsla?%s*%b()")
      if token then return parse_color(token) end
    end
  end
  return nil
end

local function hex_to_rgb(hex)
  return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

local function luminance(r, g, b)
  local function lin(c)
    c = c / 255; return (c <= 0.04045) and (c / 12.92) or (((c + 0.055) / 1.055) ^ 2.4)
  end
  local R, G, B = lin(r), lin(g), lin(b)
  return 0.2126 * R + 0.7152 * G + 0.0722 * B
end

local function pick_fg(hex)
  local r, g, b = hex_to_rgb(hex)
  return (luminance(r, g, b) < 0.5) and "#ffffff" or "#000000"
end

local function close_preview()
  if state.win and vim.api.nvim_win_is_valid(state.win) then vim.api.nvim_win_close(state.win, true) end
  if state.map_buf and vim.api.nvim_buf_is_loaded(state.map_buf) then
    pcall(vim.keymap.del, "n", "<Esc>",
      { buffer = state.map_buf })
  end
  state.win, state.buf, state.map_buf = nil, nil, nil
end

local function preview_color()
  local col = color_under_cursor()
  if not col then
    vim.notify("No color at cursor", vim.log.levels.WARN, { title = "Color Preview" })
    return
  end

  close_preview()

  local main_buf = vim.api.nvim_get_current_buf()
  local buf = vim.api.nvim_create_buf(false, true)
  local fg = pick_fg(col)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "  " .. col .. "  " })
  vim.api.nvim_set_hl(0, "ColorPreviewHL", { bg = col, fg = fg })
  local len = #("  " .. col .. "  ")
  vim.api.nvim_buf_set_extmark(buf, ns, 0, 0, {
    end_row = 0,
    end_col = len,
    hl_group = "ColorPreviewHL",
    hl_eol = true,
  })

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    row = 1,
    col = 1,
    width = #col + 4,
    height = 1,
    style = "minimal",
    border = "rounded",
    noautocmd = true
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "BufHidden", "InsertEnter" }, {
    once = true,
    callback = close_preview,
  })

  vim.keymap.set("n", "<Esc>", function()
    close_preview()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end, { buffer = main_buf, silent = true })

  state.win, state.buf, state.map_buf = win, buf, main_buf
end

vim.keymap.set("n", "<leader>a", preview_color, { desc = "Preview CSS color under cursor" })
