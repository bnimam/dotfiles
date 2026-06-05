-- Cobalt2 — port of Wes Bos's Cobalt2 VSCode theme
-- https://github.com/wesbos/cobalt2-vscode (theme/cobalt2.json)
-- into NvChad's base46 theme format.
--
-- This is a custom user theme: it lives in lua/themes/ so base46 picks it up
-- via `require("themes.cobalt")` without touching the base46 plugin itself.

local M = {}

-- NvChad UI palette (base_30) ------------------------------------------------
M.base_30 = {
  white         = "#ffffff", -- editor.foreground
  darker_black  = "#15232d", -- sideBar.background
  black         = "#193549", -- editor.background
  black2        = "#122738", -- tab.inactiveBackground / panel
  one_bg        = "#1F4662", -- editor.lineHighlightBackground
  one_bg2       = "#234E6D", -- editor.lineHighlightBorder
  one_bg3       = "#2B5B7D",
  grey          = "#3B5364", -- editorIndentGuide.background
  grey_fg       = "#5B7E9E",
  grey_fg2      = "#7D99B2",
  light_grey    = "#aaaaaa", -- workbench foreground / line numbers
  red           = "#ff628c", -- constants / deleted
  baby_pink     = "#FF68B8", -- semantic type / interface
  pink          = "#fb94ff", -- variable.language / JS storage.type.function
  line          = "#1F4662", -- splits / borders
  green         = "#3ad900", -- template strings / diff added / untracked
  vibrant_green = "#a5ff90", -- strings
  nord_blue     = "#38a1ff",
  blue          = "#0088ff", -- comments / links / buttons
  yellow        = "#ffc600", -- THE cobalt2 yellow: functions, storage, cursor
  sun           = "#ffee80", -- punctuation.definition.parameters / CSS values
  purple        = "#fb94ff",
  dark_purple   = "#d973de",
  teal          = "#80ffbb", -- support / TS entity.name.type
  orange        = "#ff9d00", -- keywords
  cyan          = "#9effff", -- tags / properties / meta
  statusline_bg = "#15232d", -- statusBar.background
  lightbg       = "#1F4662",
  pmenu_bg      = "#ffc600", -- accent (badges, progress bar)
  folder_bg     = "#0088ff",
  lavender      = "#e1efff", -- variables / punctuation
}

-- base16 palette -------------------------------------------------------------
M.base_16 = {
  base00 = "#193549", -- bg                         (editor.background)
  base01 = "#1F4662", -- lighter bg / cursorline    (lineHighlightBackground)
  base02 = "#0050A4", -- selection                  (editor.selectionBackground)
  base03 = "#3B5364", -- nontext / whitespace       (indent guides)
  base04 = "#aaaaaa", -- dark fg / line numbers     (editorLineNumber)
  base05 = "#e1efff", -- default fg / variables     (variable, punctuation)
  base06 = "#ffffff", -- light fg
  base07 = "#ffffff", -- lightest fg
  base08 = "#ff628c", -- red: constants, numbers, deleted
  base09 = "#ff628c", -- numbers, booleans          (constant)
  base0A = "#ffc600", -- yellow: storage, classes, entity
  base0B = "#a5ff90", -- green: strings
  base0C = "#9effff", -- cyan: tags, properties, meta
  base0D = "#ffc600", -- functions                  (entity / semantic function)
  base0E = "#ff9d00", -- keywords, conditionals     (keyword)
  base0F = "#e1efff", -- punctuation, delimiters
}

-- Fix-ups so the result matches Cobalt2's syntax intent rather than the
-- generic base16 slot meanings (base46 routes many groups through base08/0A).
M.polish_hl = {
  treesitter = {
    ["@variable"]            = { fg = M.base_30.white },      -- semantic variable #fff
    ["@variable.member"]     = { fg = M.base_30.cyan },       -- semantic property #9effff
    ["@variable.member.key"] = { fg = M.base_30.cyan },
    ["@property"]            = { fg = M.base_30.cyan },
    ["@module"]              = { fg = M.base_30.lavender },
    ["@variable.parameter"]  = { fg = M.base_30.lavender },   -- params fall back to textmate variable #e1efff
    ["@variable.builtin"]    = { fg = M.base_30.pink },       -- this #fb94ff
    ["@variable.builtin.python"] = { fg = M.base_30.cyan },   -- self/cls #9effff (cobalt2 python rule)

    ["@function"]            = { fg = M.base_30.yellow },     -- #ffc600
    ["@function.call"]       = { fg = M.base_30.yellow },
    ["@function.method"]     = { fg = M.base_30.yellow },
    ["@function.method.call"] = { fg = M.base_30.yellow },
    ["@function.builtin"]    = { fg = M.base_30.orange },     -- support.function
    ["@constructor"]         = { fg = M.base_30.yellow },

    ["@keyword"]             = { fg = M.base_30.orange },     -- #ff9d00
    ["@keyword.function"]    = { fg = M.base_30.orange },
    ["@keyword.return"]      = { fg = M.base_30.orange },
    ["@operator"]            = { fg = M.base_30.orange },     -- keyword.operator

    ["@type"]                = { fg = M.base_30.baby_pink, italic = true }, -- semantic type #FF68B8
    ["@type.builtin"]        = { fg = M.base_30.baby_pink, italic = true },
    ["@type.definition"]     = { fg = M.base_30.baby_pink, italic = true },

    ["@tag"]                 = { fg = M.base_30.cyan },       -- entity.name.tag #9effff
    ["@tag.builtin"]         = { fg = M.base_30.cyan },
    ["@tag.attribute"]       = { fg = M.base_30.yellow, italic = true },
    ["@tag.delimiter"]       = { fg = M.base_30.lavender },

    ["@punctuation.bracket"]   = { fg = M.base_30.lavender },
    ["@punctuation.delimiter"] = { fg = M.base_30.lavender },
    ["@punctuation.special"]   = { fg = M.base_30.sun },      -- template ${} #ffee80

    ["@string.regexp"]       = { fg = M.base_30.teal },       -- support #80ffbb
    ["@string.regex"]        = { fg = M.base_30.teal },
    ["@string.escape"]       = { fg = M.base_30.sun },

    ["@comment"]             = { fg = M.base_30.blue, italic = true }, -- #0088ff
  },

  syntax = {
    Identifier = { fg = M.base_30.lavender },
    Function   = { fg = M.base_30.yellow },
    Statement  = { fg = M.base_30.orange },
    Operator   = { fg = M.base_30.orange },
    Type       = { fg = M.base_30.baby_pink, italic = true },
    Typedef    = { fg = M.base_30.baby_pink, italic = true },
    Comment    = { fg = M.base_30.blue, italic = true },
  },

  defaults = {
    Comment    = { fg = M.base_30.blue, italic = true },
    Operator   = { fg = M.base_30.orange },
    Visual     = { bg = "#0050A4" },                          -- selectionBackground
    CursorLine = { bg = "#1F4662" },                          -- lineHighlightBackground
    Search     = { fg = M.base_30.white, bg = "#607532" },    -- findMatchHighlight #CAD40F66 over bg
    IncSearch  = { fg = M.base_30.white, bg = "#754D2C" },    -- findMatch #FF720066 over bg
    CurSearch  = { fg = M.base_30.white, bg = "#754D2C" },
    MatchParen = { bg = "#0d3a58" },                          -- editorBracketMatch
    LineNr     = { fg = "#aaaaaa" },                          -- editorLineNumber
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "cobalt")

return M
