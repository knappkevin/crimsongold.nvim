# crimsongold.nvim

A dark **crimson & gold** colorscheme for Neovim, built from the
[Omarchy](https://github.com/basecamp/omarchy) `crimson-gold` theme
(Spicetify *Starry Night – Sunrise* inspired): deep crimson-black backgrounds,
a gold accent family, and rose tones.

## Palette

```ansi
Background            [38;2;18;18;18m████[0m  #121212     Gold                  [38;2;219;180;44m████[0m  #DBB42C
Dark background       [38;2;12;12;12m████[0m  #0c0c0c     Gold dim              [38;2;186;160;7m████[0m  #baa007
Deeper background     [38;2;12;1;1m████[0m  #0C0101       Gold bright           [38;2;255;193;7m████[0m  #FFC107
Lighter background    [38;2;37;1;1m████[0m  #250101       Orange                [38;2;234;192;39m████[0m  #eac027
Foreground            [38;2;190;190;190m████[0m  #bebebe  Blue                  [38;2;230;142;13m████[0m  #e68e0d
Bright foreground     [38;2;234;234;234m████[0m  #eaeaea  Blue bright           [38;2;245;158;11m████[0m  #f59e0b
Muted                 [38;2;138;138;141m████[0m  #8a8a8d  Red                   [38;2;238;51;51m████[0m  #EE3333
Faint                 [38;2;68;68;68m████[0m  #444444     Red bright            [38;2;255;51;51m████[0m  #FF3333
Selection             [38;2;119;0;0m████[0m  #770000      Crimson               [38;2;185;28;28m████[0m  #b91c1c
Cursor line           [38;2;28;28;28m████[0m  #1c1c1c     Crimson deep          [38;2;135;0;0m████[0m  #870000
                                                            Rose                  [38;2;211;95;95m████[0m  #D35F5F
```

## Showcase

```ansi
[38;2;138;138;141m-- crimsongold.nvim[0m
[38;2;238;51;51mlocal[0m [38;2;190;190;190mTheme[0m [38;2;211;95;95m=[0m [38;2;211;95;95m{}[0m
[38;2;238;51;51mfunction[0m [38;2;219;180;44mTheme.setup[0m[38;2;190;190;190m([0m[38;2;138;138;141mopts[0m[38;2;190;190;190m)[0m
  [38;2;190;190;190mopts[0m [38;2;211;95;95m=[0m [38;2;190;190;190mopts[0m [38;2;211;95;95mor[0m [38;2;230;142;13m{}[0m
  [38;2;238;51;51mlocal[0m [38;2;230;142;13mdark[0m [38;2;211;95;95m=[0m [38;2;234;192;39m"#0C0101"[0m
  [38;2;238;51;51mif[0m [38;2;190;190;190mopts.[0m[38;2;234;192;39mtransparent[0m [38;2;238;51;51mthen[0m
    [38;2;219;180;44mvim.api.nvim_set_hl[0m[38;2;190;190;190m([0m[38;2;255;193;7m0[0m[38;2;190;190;190m, [0m[38;2;234;192;39m"Normal"[0m[38;2;190;190;190m, [0m[38;2;230;142;13m{}[0m[38;2;190;190;190m)[0m
  [38;2;238;51;51mend[0m
[38;2;238;51;51mend[0m
[38;2;238;51;51mreturn[0m [38;2;190;190;190mTheme[0m
```

```ansi
[38;2;190;190;190mBackground:[0m [48;2;18;18;18m  [0m    [38;2;190;190;190mSearch:[0m [48;2;219;180;44m  [0m    [38;2;190;190;190mSelection:[0m [48;2;119;0;0m  [0m    [38;2;190;190;190mCursor line:[0m [48;2;28;28;28m  [0m
```

## Install

```lua
-- lazy.nvim
{ "knappkevin/crimsongold.nvim", priority = 1000, config = true }
```

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
