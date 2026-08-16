local M = {}

local function blend(fg, bg, alpha)
  local function ch(hex, i)
    return tonumber(hex:sub(i, i + 1), 16)
  end
  local r = {}
  for i = 2, 6, 2 do
    r[#r + 1] = math.floor(ch(fg, i) * alpha + ch(bg, i) * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", r[1], r[2], r[3])
end

M.palette = {
  mode = "dark",

  bg = "#121212",
  bg_dark = "#0c0c0c",
  bg_darker = "#0C0101",
  bg_light = "#250101",

  fg = "#bebebe",
  fg_bright = "#eaeaea",
  fg_dim = "#8a8a8d",
  fg_faint = "#444444",

  gold = "#DBB42C",
  gold_dim = "#baa007",
  gold_bright = "#FFC107",
  orange = "#eac027",
  blue = "#e68e0d",
  blue_bright = "#f59e0b",

  red = "#EE3333",
  red_bright = "#FF3333",
  crimson = "#b91c1c",
  crimson_deep = "#870000",
  crimson_dim = "#770000",
  magenta = "#D35F5F",

  cyan = "#EE0000",

  bg_cursor = blend("#ffffff", "#121212", 0.04),
  bg_select = "#770000",
  bg_match = blend("#770000", "#121212", 0.45),
  bg_float = "#0C0101",
  bg_panel = "#0c0c0c",
  bg_diag_err = blend("#EE3333", "#121212", 0.09),
  bg_diag_warn = blend("#FFC107", "#121212", 0.08),
  bg_diag_info = blend("#D35F5F", "#121212", 0.09),
  bg_diag_hint = "#1a1a1a",
  fg_on_accent = "#121212",
  fg_on_select = "#eaeaea",
}

M.terminal = {
  "#0C0101",
  "#EE3333",
  "#FFC107",
  "#eac027",
  "#e68e0d",
  "#D35F5F",
  "#baa007",
  "#bebebe",
  "#444444",
  "#FF3333",
  "#FFC107",
  "#FFC107",
  "#f59e0b",
  "#D35F5F",
  "#DBB42C",
  "#eaeaea",
}

M.blend = blend

return M
