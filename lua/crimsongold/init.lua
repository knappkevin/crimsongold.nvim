local M = {}

local config = {
  transparent = false,
  italic = true,
  overrides = {},
}

local function merge(t, default)
  if t == nil then
    return
  end
  for k, v in pairs(t) do
    if type(v) == "table" and type(default[k]) == "table" then
      merge(v, default[k])
    else
      default[k] = v
    end
  end
end

function M.setup(opts)
  merge(opts, config)
end

function M.colors()
  return require("crimsongold.palette").palette
end

function M.load()
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "crimsongold"

  local palette = require("crimsongold.palette")

  for i, color in ipairs(palette.terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end

  require("crimsongold.highlights").apply(palette.palette, config)

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("Crimsongold", { clear = true }),
    callback = function()
      if vim.g.colors_name == "crimsongold" then
        require("crimsongold.highlights").apply(palette.palette, config)
      end
    end,
  })
end

return M
