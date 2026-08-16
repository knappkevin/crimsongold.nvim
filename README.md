# crimsongold.nvim

A dark Neovim colorscheme based on the [Omarchy](https://github.com/basecamp/omarchy) `crimson-gold` theme with a gold accent family and rose tones.

## Install

```lua
-- lazy.nvim
{ "crimsongold/crimsongold.nvim", priority = 1000, config = true }
```

Then set it:

```lua
vim.cmd.colorscheme("crimsongold")
```

## Options

```lua
require("crimsongold").setup({
  transparent = false, -- transparent editor background
  italic = true,       -- italic comments / emphasis
  overrides = {},      -- per-group highlight overrides
})
```

`overrides` accepts the same shape as highlight specs:

```lua
overrides = {
  Comment = { fg = "#8a8a8d", style = "italic" },
  Normal = { bg = "#0c0c0c" },
  String = function(hl, palette) return vim.tbl_deep_extend("force", hl, { fg = palette.gold }) end,
}
```

Access the palette programmatically with `require("crimsongold").colors()`.

## Palette

| Role        | Color     |
| ----------- | --------- |
| Background  | `#121212` |
| Dark bg     | `#0c0c0c` |
| Deeper bg   | `#0C0101` |
| Lighter bg  | `#250101` |
| Foreground  | `#bebebe` |
| Bright fg   | `#eaeaea` |
| Muted       | `#8a8a8d` |
| Faint       | `#444444` |
| Gold        | `#DBB42C` |
| Gold bright | `#FFC107` |
| Red         | `#EE3333` |
| Crimson     | `#b91c1c` |
| Selection   | `#770000` |
| Rose        | `#D35F5F` |
