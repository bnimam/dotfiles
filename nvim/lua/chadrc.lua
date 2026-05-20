-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "chadracula",
    hl_add = {
        -- quick-scope: highlight first-occurrence letters for f/F/t/T motions
        QuickScopePrimary   = { underline = true, bold = true, fg = "#ff007c" },
        QuickScopeSecondary = { underline = true, bold = true, fg = "#00dfff" },
    },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
