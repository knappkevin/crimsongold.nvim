local M = {}

local function style_attrs(style)
  local attrs = {}
  if type(style) == "string" then
    for s in style:gmatch("%S+") do
      attrs[s] = true
    end
  elseif type(style) == "table" then
    for _, s in ipairs(style) do
      attrs[s] = true
    end
  end
  return attrs
end

local function hl(group, val)
  if not val or next(val) == nil then
    return
  end
  if val.link then
    vim.api.nvim_set_hl(0, group, { link = val.link })
    return
  end
  local cfg = {}
  if val.fg then
    cfg.fg = val.fg
  end
  if val.bg then
    cfg.bg = val.bg
  end
  if val.sp then
    cfg.sp = val.sp
  end
  for k in pairs(style_attrs(val.style)) do
    cfg[k] = true
  end
  vim.api.nvim_set_hl(0, group, cfg)
end

function M.apply(p, opts)
  opts = opts or {}
  local italic = opts.italic ~= false
  local it = italic and "italic" or ""

  local base = {
    Normal = { fg = p.fg, bg = opts.transparent and nil or p.bg },
    NormalFloat = { fg = p.fg, bg = p.bg_float },
    FloatBorder = { fg = p.gold_dim, bg = p.bg_float },
    FloatTitle = { fg = p.gold, bg = p.bg_float, style = "bold" },
    NormalSB = { fg = p.fg, bg = p.bg_panel },
    EndOfBuffer = { fg = p.bg_darker },
    NonText = { fg = p.bg_dark },
    Whitespace = { fg = p.bg_cursor },
    SpecialKey = { fg = p.gold_dim },
    Conceal = { fg = p.fg_faint },

    ColorColumn = { bg = p.bg_dark },
    CursorColumn = { bg = p.bg_cursor },
    CursorLine = { bg = p.bg_cursor },
    CursorLineNr = { fg = p.gold_bright, style = "bold" },
    CursorLineFold = { fg = p.fg_dim },
    CursorLineSign = { fg = p.fg_dim },
    LineNr = { fg = p.fg_faint },
    LineNrAbove = { fg = p.bg_light },
    LineNrBelow = { fg = p.bg_light },

    Cursor = { fg = p.bg_darker, bg = p.gold_bright },
    lCursor = { fg = p.bg_darker, bg = p.gold_bright },
    TermCursor = { fg = p.bg_darker, bg = p.gold_bright },
    TermCursorNC = { fg = p.bg_darker, bg = p.gold_dim },

    Visual = { fg = p.fg_on_select, bg = p.bg_select },
    VisualNOS = { fg = p.fg_on_select, bg = p.bg_select },
    MatchParen = { fg = p.fg_on_select, bg = p.bg_match, style = "bold" },

    Search = { fg = p.fg_on_accent, bg = p.gold },
    IncSearch = { fg = p.bg_darker, bg = p.gold_bright },
    CurSearch = { fg = p.bg_darker, bg = p.gold_bright },
    QuickFixLine = { fg = p.fg_on_accent, bg = p.gold },

    StatusLine = { fg = p.fg_bright, bg = p.bg_light },
    StatusLineNC = { fg = p.fg_faint, bg = p.bg_panel },
    StatusLineTerm = { fg = p.fg_bright, bg = p.bg_light },
    StatusLineTermNC = { fg = p.fg_faint, bg = p.bg_panel },
    WinBar = { fg = p.fg_dim, bg = p.bg },
    WinBarNC = { fg = p.fg_faint, bg = p.bg },
    WinSeparator = { fg = p.bg_light, bg = nil },
    VertSplit = { fg = p.bg_light, bg = nil },

    TabLine = { fg = p.fg_faint, bg = p.bg_panel },
    TabLineFill = { bg = p.bg_panel },
    TabLineSel = { fg = p.gold, bg = p.bg, style = "bold" },

    Pmenu = { fg = p.fg, bg = p.bg_float },
    PmenuSel = { fg = p.fg_on_select, bg = p.bg_select },
    PmenuKind = { fg = p.gold_dim, bg = p.bg_float },
    PmenuKindSel = { fg = p.fg_on_select, bg = p.bg_select },
    PmenuExtra = { fg = p.fg_faint, bg = p.bg_float },
    PmenuExtraSel = { fg = p.fg_on_select, bg = p.bg_select },
    PmenuSbar = { bg = p.bg_panel },
    PmenuThumb = { bg = p.fg_faint },
    WildMenu = { fg = p.fg_on_select, bg = p.bg_select },

    Title = { fg = p.gold, style = "bold" },
    Directory = { fg = p.gold_bright },
    Question = { fg = p.gold_dim },
    MoreMsg = { fg = p.gold_dim, style = "bold" },
    ModeMsg = { fg = p.fg_dim, style = "bold" },
    MsgSeparator = { fg = p.gold_dim },
    WarningMsg = { fg = p.red },
    ErrorMsg = { fg = p.red_bright, bg = p.bg_diag_err },
    Error = { fg = p.red_bright },
    Todo = { fg = p.gold, bg = p.crimson_dim, style = "bold" },

    Folded = { fg = p.fg_dim, bg = p.bg_panel },
    FoldColumn = { fg = p.fg_faint, bg = p.bg },
    SignColumn = { fg = p.fg_faint, bg = opts.transparent and nil or p.bg },
    SignColumnSB = { fg = p.fg_faint, bg = p.bg_panel },

    SpellBad = { sp = p.red_bright, style = { "undercurl" } },
    SpellCap = { sp = p.gold, style = { "undercurl" } },
    SpellLocal = { sp = p.gold_dim, style = { "undercurl" } },
    SpellRare = { sp = p.magenta, style = { "undercurl" } },

    DiffAdd = { fg = p.gold_bright, bg = p.bg_diag_warn },
    DiffChange = { fg = p.blue, bg = p.bg_diag_info },
    DiffDelete = { fg = p.red_bright, bg = p.bg_diag_err },
    DiffText = { fg = p.fg_on_select, bg = p.bg_select },
  }

  local syntax = {
    Comment = { fg = p.fg_dim, style = it },
    Todo = { fg = p.gold, bg = p.crimson_dim, style = "bold" },

    Constant = { fg = p.gold_bright },
    String = { fg = p.orange },
    Character = { fg = p.gold },
    Number = { fg = p.gold_bright },
    Boolean = { fg = p.red },
    Float = { fg = p.gold_bright },

    Identifier = { fg = p.fg },
    Function = { fg = p.gold },

    Statement = { fg = p.red },
    Conditional = { fg = p.red },
    Repeat = { fg = p.red },
    Label = { fg = p.gold },
    Operator = { fg = p.magenta },
    Keyword = { fg = p.red },
    Exception = { fg = p.red },

    PreProc = { fg = p.red },
    Include = { fg = p.red },
    Define = { fg = p.red },
    Macro = { fg = p.red },
    PreCondit = { fg = p.red },

    Type = { fg = p.magenta },
    StorageClass = { fg = p.red },
    Structure = { fg = p.red },
    Typedef = { fg = p.magenta, style = it },

    Special = { fg = p.gold },
    SpecialChar = { fg = p.gold },
    Tag = { fg = p.gold },
    Delimiter = { fg = p.fg_dim },
    SpecialComment = { fg = p.gold_dim, style = it },
    Debug = { fg = p.gold_bright },

    Underlined = { fg = p.gold, style = "underline" },
    Ignore = { fg = p.bg_dark },
  }

  local treesitter = {
    ["@comment"] = { fg = p.fg_dim, style = it },
    ["@comment.error"] = { fg = p.red_bright, style = { "bold", "undercurl" } },
    ["@comment.warning"] = { fg = p.gold_bright, style = { "bold", "undercurl" } },
    ["@comment.note"] = { fg = p.fg_dim },
    ["@comment.todo"] = { fg = p.gold, bg = p.crimson_dim, style = "bold" },

    ["@punctuation.delimiter"] = { fg = p.fg_dim },
    ["@punctuation.bracket"] = { fg = p.fg },
    ["@punctuation.special"] = { fg = p.gold },

    ["@string"] = { fg = p.orange },
    ["@string.escape"] = { fg = p.gold },
    ["@string.regex"] = { fg = p.gold_bright },
    ["@string.special"] = { fg = p.magenta },
    ["@string.special.symbol"] = { fg = p.gold },
    ["@string.special.url"] = { fg = p.gold_dim, style = "underline" },
    ["@string.special.path"] = { fg = p.orange },
    ["@character"] = { fg = p.gold },
    ["@number"] = { fg = p.gold_bright },
    ["@number.float"] = { fg = p.gold_bright },
    ["@boolean"] = { fg = p.red },
    ["@float"] = { fg = p.gold_bright },

    ["@function"] = { fg = p.gold },
    ["@function.call"] = { fg = p.gold },
    ["@function.builtin"] = { fg = p.gold_bright },
    ["@function.macro"] = { fg = p.red },
    ["@method"] = { fg = p.gold },
    ["@method.call"] = { fg = p.gold },
    ["@constructor"] = { fg = p.orange },

    ["@variable"] = { fg = p.fg },
    ["@variable.builtin"] = { fg = p.magenta, style = it },
    ["@variable.parameter"] = { fg = p.fg_dim, style = it },
    ["@variable.member"] = { fg = p.orange },
    ["@property"] = { fg = p.orange },
    ["@field"] = { fg = p.orange },

    ["@type"] = { fg = p.magenta },
    ["@type.builtin"] = { fg = p.magenta, style = it },
    ["@type.definition"] = { fg = p.magenta },
    ["@type.qualifier"] = { fg = p.red },
    ["@namespace"] = { fg = p.magenta },
    ["@module"] = { fg = p.magenta },

    ["@keyword"] = { fg = p.red },
    ["@keyword.function"] = { fg = p.red },
    ["@keyword.return"] = { fg = p.red },
    ["@keyword.operator"] = { fg = p.red },
    ["@keyword.import"] = { fg = p.red },
    ["@keyword.repeat"] = { fg = p.red },
    ["@keyword.conditional"] = { fg = p.red },
    ["@keyword.exception"] = { fg = p.red },
    ["@keyword.type"] = { fg = p.magenta },
    ["@keyword.storage"] = { fg = p.red },
    ["@conditional"] = { fg = p.red },
    ["@repeat"] = { fg = p.red },
    ["@exception"] = { fg = p.red },
    ["@debug"] = { fg = p.gold_bright },
    ["@label"] = { fg = p.gold },
    ["@include"] = { fg = p.red },
    ["@operator"] = { fg = p.magenta },
    ["@preproc"] = { fg = p.red },
    ["@define"] = { fg = p.red },
    ["@macro"] = { fg = p.red },
    ["@storageclass"] = { fg = p.red },
    ["@structure"] = { fg = p.red },
    ["@attribute"] = { fg = p.gold },
    ["@tag"] = { fg = p.red },
    ["@tag.attribute"] = { fg = p.orange },
    ["@tag.delimiter"] = { fg = p.fg_dim },

    ["@constant"] = { fg = p.gold_bright },
    ["@constant.builtin"] = { fg = p.red_bright },
    ["@constant.macro"] = { fg = p.gold_bright },
    ["@constant.character"] = { fg = p.gold },
    ["@constant.character.escape"] = { fg = p.gold },
    ["@constant.numeric"] = { fg = p.gold_bright },
    ["@symbol"] = { fg = p.gold },

    ["@text"] = { fg = p.fg },
    ["@text.strong"] = { style = "bold" },
    ["@text.emphasis"] = { style = it },
    ["@text.underline"] = { style = "underline" },
    ["@text.strike"] = { style = "strikethrough" },
    ["@text.title"] = { fg = p.gold, style = "bold" },
    ["@text.literal"] = { fg = p.orange },
    ["@text.quote"] = { fg = p.magenta, style = it },
    ["@text.uri"] = { fg = p.gold_dim, style = "underline" },
    ["@text.url"] = { fg = p.gold_dim, style = "underline" },
    ["@text.math"] = { fg = p.gold_bright },
    ["@text.environment"] = { fg = p.gold },
    ["@text.environment.name"] = { fg = p.gold },
    ["@text.reference"] = { fg = p.gold },
    ["@text.todo"] = { fg = p.gold, bg = p.crimson_dim, style = "bold" },
    ["@text.note"] = { fg = p.gold_dim },
    ["@text.warning"] = { fg = p.red },
    ["@text.danger"] = { fg = p.red_bright },
    ["@text.diff.add"] = { fg = p.gold_bright },
    ["@text.diff.delete"] = { fg = p.red_bright },
    ["@text.unit"] = { fg = p.gold },

    ["@markup.heading"] = { fg = p.gold, style = "bold" },
    ["@markup.heading.1"] = { fg = p.gold, style = "bold" },
    ["@markup.heading.2"] = { fg = p.gold, style = "bold" },
    ["@markup.heading.3"] = { fg = p.orange, style = "bold" },
    ["@markup.heading.4"] = { fg = p.blue, style = "bold" },
    ["@markup.heading.5"] = { fg = p.magenta, style = "bold" },
    ["@markup.heading.6"] = { fg = p.fg_dim, style = "bold" },
    ["@markup.bold"] = { style = "bold" },
    ["@markup.italic"] = { style = it },
    ["@markup.strikethrough"] = { style = "strikethrough" },
    ["@markup.underline"] = { style = "underline" },
    ["@markup.link"] = { fg = p.gold_dim, style = "underline" },
    ["@markup.link.url"] = { fg = p.gold_dim, style = "underline" },
    ["@markup.link.label"] = { fg = p.gold },
    ["@markup.link.text"] = { fg = p.fg },
    ["@markup.list"] = { fg = p.magenta },
    ["@markup.list.checked"] = { fg = p.gold_bright },
    ["@markup.list.unchecked"] = { fg = p.magenta },
    ["@markup.raw"] = { fg = p.orange },
    ["@markup.raw.block"] = { fg = p.orange },
    ["@markup.quote"] = { fg = p.magenta, style = it },
    ["@markup.inline"] = { fg = p.orange },

    ["@comment.documentation"] = { fg = p.fg_dim, style = it },
    ["@error"] = { fg = p.red_bright },
    ["@warning"] = { fg = p.gold_bright },
  }

  local lsp = {
    DiagnosticError = { fg = p.red_bright },
    DiagnosticWarn = { fg = p.gold_bright },
    DiagnosticInfo = { fg = p.magenta },
    DiagnosticHint = { fg = p.fg_dim },
    DiagnosticOk = { fg = p.gold_bright },

    DiagnosticUnderlineError = { sp = p.red_bright, style = { "undercurl" } },
    DiagnosticUnderlineWarn = { sp = p.gold_bright, style = { "undercurl" } },
    DiagnosticUnderlineInfo = { sp = p.magenta, style = { "undercurl" } },
    DiagnosticUnderlineHint = { sp = p.fg_dim, style = { "undercurl" } },
    DiagnosticUnderlineOk = { sp = p.gold_bright, style = { "undercurl" } },

    DiagnosticVirtualTextError = { fg = p.red_bright, bg = p.bg_diag_err },
    DiagnosticVirtualTextWarn = { fg = p.gold_bright, bg = p.bg_diag_warn },
    DiagnosticVirtualTextInfo = { fg = p.magenta, bg = p.bg_diag_info },
    DiagnosticVirtualTextHint = { fg = p.fg_dim, bg = p.bg_diag_hint },
    DiagnosticVirtualTextOk = { fg = p.gold_bright, bg = p.bg_diag_warn },

    DiagnosticFloatingError = { fg = p.red_bright },
    DiagnosticFloatingWarn = { fg = p.gold_bright },
    DiagnosticFloatingInfo = { fg = p.magenta },
    DiagnosticFloatingHint = { fg = p.fg_dim },

    DiagnosticSignError = { fg = p.red_bright },
    DiagnosticSignWarn = { fg = p.gold_bright },
    DiagnosticSignInfo = { fg = p.magenta },
    DiagnosticSignHint = { fg = p.fg_dim },
    DiagnosticSignOk = { fg = p.gold_bright },

    LspReferenceText = { bg = p.bg_light },
    LspReferenceRead = { bg = p.bg_light },
    LspReferenceWrite = { bg = p.bg_light },
    LspCodeLens = { fg = p.fg_faint },
    LspCodeLensSeparator = { fg = p.fg_faint },
    LspSignatureActiveParameter = { fg = p.gold, style = { "bold", "underline" } },
    LspInlayHint = { fg = p.fg_faint },
    LspSemanticHighlight = { fg = p.fg },
  }

  local diff = {
    diffAdded = { fg = p.gold_bright },
    diffRemoved = { fg = p.red_bright },
    diffChanged = { fg = p.blue },
    diffOldFile = { fg = p.red_bright },
    diffNewFile = { fg = p.gold_bright },
    diffFile = { fg = p.gold },
    diffLine = { fg = p.magenta },
    diffIndexLine = { fg = p.magenta },
    diffSubname = { fg = p.magenta },
    diffComment = { fg = p.fg_dim, style = it },
  }

  local plugins = {
    GitSignsAdd = { fg = p.gold_bright },
    GitSignsAddLn = { fg = p.gold_bright },
    GitSignsAddNr = { fg = p.gold_bright },
    GitSignsChange = { fg = p.blue },
    GitSignsChangeLn = { fg = p.blue },
    GitSignsChangeNr = { fg = p.blue },
    GitSignsDelete = { fg = p.red_bright },
    GitSignsDeleteLn = { fg = p.red_bright },
    GitSignsDeleteNr = { fg = p.red_bright },
    GitSignsChangedelete = { fg = p.red_bright },
    GitSignsUntracked = { fg = p.fg_dim },

    SignifySignAdd = { fg = p.gold_bright },
    SignifySignChange = { fg = p.blue },
    SignifySignDelete = { fg = p.red_bright },

    TelescopeBorder = { fg = p.gold_dim, bg = p.bg_float },
    TelescopePromptBorder = { fg = p.gold_dim, bg = p.bg_panel },
    TelescopePromptNormal = { fg = p.fg_bright, bg = p.bg_panel },
    TelescopePromptTitle = { fg = p.fg_on_accent, bg = p.gold },
    TelescopePromptPrefix = { fg = p.gold },
    TelescopeResultsTitle = { fg = p.fg_on_accent, bg = p.gold_dim },
    TelescopeResultsNormal = { fg = p.fg, bg = p.bg_float },
    TelescopeResultsDiffAdd = { fg = p.gold_bright },
    TelescopeResultsDiffDelete = { fg = p.red_bright },
    TelescopePreviewTitle = { fg = p.fg_on_accent, bg = p.crimson_dim },
    TelescopePreviewNormal = { fg = p.fg, bg = p.bg_float },
    TelescopeSelection = { fg = p.fg_bright, bg = p.bg_select },
    TelescopeMultiSelection = { fg = p.gold },
    TelescopeMatching = { fg = p.gold_bright },
    TelescopeGrep = { fg = p.gold_bright },

    NvimTreeNormal = { fg = p.fg, bg = p.bg_panel },
    NvimTreeNormalNC = { fg = p.fg, bg = p.bg_panel },
    NvimTreeRootFolder = { fg = p.gold, style = "bold" },
    NvimTreeFolderIcon = { fg = p.blue },
    NvimTreeFolderName = { fg = p.fg_bright },
    NvimTreeOpenedFolderName = { fg = p.gold, style = "bold" },
    NvimTreeEmptyFolderName = { fg = p.fg_dim },
    NvimTreeFileIcon = { fg = p.fg_dim },
    NvimTreeSymlink = { fg = p.gold_dim },
    NvimTreeGitDirty = { fg = p.gold_bright },
    NvimTreeGitStaged = { fg = p.gold },
    NvimTreeGitDeleted = { fg = p.red_bright },
    NvimTreeGitMerge = { fg = p.magenta },
    NvimTreeGitNew = { fg = p.gold_bright },
    NvimTreeIndentMarker = { fg = p.bg_light },

    BufferLineBackground = { fg = p.fg_dim, bg = p.bg_panel },
    BufferLineBuffer = { fg = p.fg_dim, bg = p.bg_panel },
    BufferLineBufferSelected = { fg = p.gold, bg = p.bg, style = "bold" },
    BufferLineBufferVisible = { fg = p.fg_dim, bg = p.bg_panel },
    BufferLineModified = { fg = p.red },
    BufferLineModifiedSelected = { fg = p.gold_bright },
    BufferLineModifiedVisible = { fg = p.red },
    BufferLineError = { fg = p.red_bright },
    BufferLineErrorSelected = { fg = p.red_bright },
    BufferLineWarning = { fg = p.gold_bright },
    BufferLineWarningSelected = { fg = p.gold_bright },
    BufferLineHint = { fg = p.fg_dim },
    BufferLineInfo = { fg = p.magenta },
    BufferLineCloseButton = { fg = p.fg_faint },
    BufferLineCloseButtonSelected = { fg = p.fg_dim },
    BufferLineDuplicate = { fg = p.fg_faint },
    BufferLineDuplicateSelected = { fg = p.gold },
    BufferLineFill = { bg = p.bg_panel },
    BufferLineIndicatorSelected = { fg = p.gold },

    WhichKey = { fg = p.fg_bright },
    WhichKeyGroup = { fg = p.gold },
    WhichKeyValue = { fg = p.red },
    WhichKeyDesc = { fg = p.fg_dim },
    WhichKeySeparator = { fg = p.gold_dim },
    WhichKeyFloat = { bg = p.bg_float },
    WhichKeyBorder = { fg = p.gold_dim, bg = p.bg_float },

    CmpItemMenu = { fg = p.fg_dim },
    CmpItemAbbr = { fg = p.fg },
    CmpItemAbbrMatch = { fg = p.gold_bright },
    CmpItemAbbrMatchFuzzy = { fg = p.gold_bright },
    CmpItemKind = { fg = p.magenta },
    CmpItemKindFunction = { fg = p.gold },
    CmpItemKindMethod = { fg = p.gold },
    CmpItemKindConstructor = { fg = p.orange },
    CmpItemKindVariable = { fg = p.fg_dim },
    CmpItemKindField = { fg = p.orange },
    CmpItemKindProperty = { fg = p.orange },
    CmpItemKindKeyword = { fg = p.red },
    CmpItemKindConstant = { fg = p.gold_bright },
    CmpItemKindStruct = { fg = p.magenta },
    CmpItemKindClass = { fg = p.magenta },
    CmpItemKindModule = { fg = p.magenta },
    CmpItemKindInterface = { fg = p.magenta },
    CmpItemKindEnum = { fg = p.gold },
    CmpItemKindOperator = { fg = p.magenta },
    CmpItemKindTypeParameter = { fg = p.magenta },
    CmpItemKindSnippet = { fg = p.red },
    CmpItemKindFile = { fg = p.fg_dim },
    CmpItemKindFolder = { fg = p.blue },
    CmpItemKindText = { fg = p.fg },
    CmpItemKindUnit = { fg = p.gold },

    LazyButton = { fg = p.fg_on_accent, bg = p.gold },
    LazyButtonActive = { fg = p.fg_on_accent, bg = p.gold_bright },
    LazyProgressTodo = { bg = p.bg_cursor },
    LazyReasonPlugin = { fg = p.fg_dim },
    LazyReasonStart = { fg = p.fg_dim },
    LazyReasonCmd = { fg = p.fg_dim },
    LazyReasonImport = { fg = p.fg_dim },
    LazyReasonRuntime = { fg = p.fg_dim },
    LazyReasonSource = { fg = p.fg_dim },
    LazyReasonConfig = { fg = p.fg_dim },
    LazyReasonKeys = { fg = p.fg_dim },
    LazyReasonEvent = { fg = p.fg_dim },
    LazyReasonFt = { fg = p.fg_dim },
    LazySpecial = { fg = p.gold },

    NoiceCmdlinePopupTitle = { fg = p.fg_on_accent, bg = p.gold },
    NoiceCmdlinePopupBorder = { fg = p.gold_dim },
    NoiceCmdlineIcon = { fg = p.gold_dim },
    NoiceConfirmBorder = { fg = p.gold_dim },
    NoiceConfirm = { fg = p.fg },
    NoiceMini = { fg = p.fg_dim },
    NoiceLspProgressTitle = { fg = p.gold, style = "bold" },
    NoiceLspProgressBorder = { fg = p.gold_dim },
    NoiceFormatProgressDone = { bg = p.gold_dim },
    NoiceFormatProgressTodo = { bg = p.bg_cursor },
    NoiceCompletionBorder = { fg = p.gold_dim },

    NotifyERRORBorder = { fg = p.red_bright },
    NotifyWARNBorder = { fg = p.gold_bright },
    NotifyINFOBorder = { fg = p.magenta },
    NotifyDEBUGBorder = { fg = p.fg_faint },
    NotifyTRACEBorder = { fg = p.gold_dim },
    NotifyERRORIcon = { fg = p.red_bright },
    NotifyWARNIcon = { fg = p.gold_bright },
    NotifyINFOIcon = { fg = p.magenta },
    NotifyDEBUGIcon = { fg = p.fg_faint },
    NotifyTRACEIcon = { fg = p.gold_dim },
    NotifyERRORTitle = { fg = p.red_bright },
    NotifyWARNTitle = { fg = p.gold_bright },
    NotifyINFOTitle = { fg = p.magenta },
    NotifyDEBUGTitle = { fg = p.fg_faint },
    NotifyTRACETitle = { fg = p.gold_dim },

    DashboardHeader = { fg = p.gold },
    DashboardFooter = { fg = p.fg_dim },
    DashboardShortCut = { fg = p.gold },
    DashboardProjectTitle = { fg = p.gold_bright },
    DashboardDesc = { fg = p.fg_dim },
    DashboardKey = { fg = p.red },
    DashboardIcon = { fg = p.gold_dim },
    DashboardProjectIcon = { fg = p.magenta },
    DashboardMruIcon = { fg = p.gold },

    AlphaHeader = { fg = p.gold },
    AlphaFooter = { fg = p.fg_dim },
    AlphaShortcut = { fg = p.gold },
    AlphaLabel = { fg = p.red },
    AlphaButtons = { fg = p.gold_bright },

    IndentBlanklineChar = { fg = p.bg_light },
    IndentBlanklineContextChar = { fg = p.gold_dim },
    IndentBlanklineContextStart = { sp = p.gold_dim, style = { "underline" } },
    IblIndent = { fg = p.bg_light },
    IblScope = { fg = p.gold_dim },
    MiniIndentscopeSymbol = { fg = p.gold_dim },

    HopNextKey = { fg = p.fg_on_accent, bg = p.gold },
    HopNextKey1 = { fg = p.fg_on_accent, bg = p.gold_bright },
    HopNextKey2 = { fg = p.gold_dim },
    HopUnmatched = { fg = p.fg_faint },

    SneakLabel = { fg = p.fg_on_accent, bg = p.gold },
    SneakLabelMask = { fg = p.gold },
    SneakScope = { bg = p.bg_light },

    LeapMatch = { fg = p.fg_on_accent, bg = p.gold },
    LeapLabelPrimary = { fg = p.fg_on_accent, bg = p.gold_bright },
    LeapLabelSecondary = { fg = p.fg_on_accent, bg = p.gold_dim },
    LeapBackdrop = { fg = p.fg_faint },
    LeapCursor = { fg = p.bg_darker, bg = p.gold_bright },

    FlashLabel = { fg = p.fg_on_accent, bg = p.gold },
    FlashBackdrop = { fg = p.fg_faint },
    FlashMatch = { fg = p.fg_on_accent, bg = p.gold },
    FlashCursor = { fg = p.bg_darker, bg = p.gold_bright },

    IlluminateWord = { bg = p.bg_light },
    IlluminateCurWord = { bg = p.bg_light },

    SymbolsOutlineConnector = { fg = p.fg_faint },
    AerialLine = { bg = p.bg_light },
    AerialGuide = { fg = p.fg_faint },

    NavicText = { fg = p.fg_dim },
    NavicSeparator = { fg = p.fg_faint },
    NavicIconsFile = { fg = p.fg_dim },
    NavicIconsModule = { fg = p.magenta },
    NavicIconsNamespace = { fg = p.magenta },
    NavicIconsPackage = { fg = p.magenta },
    NavicIconsClass = { fg = p.magenta },
    NavicIconsMethod = { fg = p.gold },
    NavicIconsProperty = { fg = p.orange },
    NavicIconsField = { fg = p.orange },
    NavicIconsConstructor = { fg = p.orange },
    NavicIconsEnum = { fg = p.gold },
    NavicIconsFunction = { fg = p.gold },
    NavicIconsVariable = { fg = p.fg_dim },
    NavicIconsConstant = { fg = p.gold_bright },
    NavicIconsKeyword = { fg = p.red },
    NavicIconsTypeParameter = { fg = p.magenta },
    NavicIconsSnippet = { fg = p.red },

    CopilotSuggestion = { fg = p.fg_faint },

    RainbowDelimiterRed = { fg = p.red },
    RainbowDelimiterYellow = { fg = p.gold_bright },
    RainbowDelimiterBlue = { fg = p.blue },
    RainbowDelimiterOrange = { fg = p.orange },
    RainbowDelimiterGreen = { fg = p.gold_bright },
    RainbowDelimiterViolet = { fg = p.magenta },
    RainbowDelimiterCyan = { fg = p.gold_dim },

    NeogitDiffAddHighlight = { fg = p.gold_bright },
    NeogitDiffDeleteHighlight = { fg = p.red_bright },
    NeogitDiffContextHighlight = { bg = p.bg_cursor },
    NeogitHunkHeader = { fg = p.gold, style = "bold" },
    NeogitHunkHeaderHighlight = { fg = p.gold, bg = p.bg_light, style = "bold" },

    DiffviewNormal = { fg = p.fg, bg = p.bg },
    DiffviewVertSplit = { fg = p.bg_light },
    DiffviewFilePanelTitle = { fg = p.gold, style = "bold" },
    DiffviewFilePanelCounter = { fg = p.gold_dim },
    DiffviewFilePanelFileName = { fg = p.fg_bright },
    DiffviewFilePanelFile = { fg = p.fg_dim },
    DiffviewStatusAdded = { fg = p.gold_bright },
    DiffviewStatusModified = { fg = p.blue },
    DiffviewStatusDeleted = { fg = p.red_bright },
    DiffviewStatusRenamed = { fg = p.magenta },

    MiniDiffSignAdd = { fg = p.gold_bright },
    MiniDiffSignChange = { fg = p.blue },
    MiniDiffSignDelete = { fg = p.red_bright },
    MiniCursorword = { bg = p.bg_light },
    MiniCursorwordCurrent = { bg = p.bg_light },
    MiniCompletionActiveParameter = { fg = p.gold, style = "underline" },
    MiniIndentscopeSymbol = { fg = p.gold_dim },
    MiniJump = { fg = p.fg_on_accent, bg = p.gold },
    MiniStarterHeader = { fg = p.gold },
    MiniStarterFooter = { fg = p.fg_dim },
    MiniStarterItemBullet = { fg = p.gold_dim },
    MiniStarterSection = { fg = p.red },
    MiniStatuslineDevinfo = { fg = p.fg_dim, bg = p.bg_panel },
    MiniStatuslineFileinfo = { fg = p.fg_dim, bg = p.bg_panel },
    MiniStatuslineModeNormal = { fg = p.fg_on_accent, bg = p.gold },
    MiniStatuslineModeInsert = { fg = p.fg_on_accent, bg = p.gold_bright },
    MiniStatuslineModeVisual = { fg = p.fg_on_select, bg = p.bg_select },
    MiniStatuslineModeReplace = { fg = p.fg_on_select, bg = p.bg_select },
    MiniStatuslineModeCommand = { fg = p.fg_on_accent, bg = p.gold_dim },
    MiniStatuslineModeOther = { fg = p.fg, bg = p.bg_light },
  }

  local groups = vim.tbl_deep_extend("force", {}, base, syntax, treesitter, lsp, diff, plugins)

  for group, val in pairs(groups) do
    hl(group, val)
  end

  if opts.overrides then
    for group, val in pairs(opts.overrides) do
      if val == false then
        vim.api.nvim_set_hl(0, group, {})
      elseif type(val) == "function" then
        val(vim.api.nvim_get_hl(0, { name = group, link = false }), p)
      else
        hl(group, val)
      end
    end
  end
end

return M
