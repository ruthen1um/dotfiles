local color_overrides = function(colors)
  local theme = colors.theme
  local palette = colors.palette

  return {
    NormalFloat = { bg = "none" },
    FloatBorder = { bg = "none" },
    FloatTitle = { bg = "none" },
    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m2 },

    --[[ lua ]]
    ["@boolean.lua"] = { bold = false, italic = true, fg = palette.peachRed },
    ["@variable.lua"] = { fg = palette.carpYellow },
    ["@keyword.lua"] = { fg = palette.springViolet2 },
    ["@keyword.operator.lua"] = { bold = false, italic = true, fg = palette.waveRed },

    --[[ cpp ]]
    ["@type.builtin.cpp"] = { fg = palette.sakuraPink },
    ["@type.cpp"] = { fg = palette.springGreen },
    ["@module.cpp"] = { fg = palette.lightBlue },
    ["@variable.cpp"] = { fg = palette.carpYellow },
    ["@property.cpp"] = { fg = palette.surimiOrange },

    --[[ editor ]]
    LineNr = { fg = palette.surimiOrange, bg = "none" },
    CursorLine = { bg = theme.ui.bg_gutter },
    CursorLineNr = { bold = false },
    StatusLine = { bg = theme.ui.bg_m1 },

    --[[ complete items ]]
    CmpItemAbbrMatch = { fg = palette.surimiOrange },

    --[[ popup windows ]]
    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
    PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
    PmenuKind = { link = "Pmenu" },
    PmenuKindSel = { link = "PmenuSel" },
    PmenuExtra = { link = "Pmenu" },
    PmenuExtraSel = { link = "PmenuSel" },
    PmenuSbar = { bg = theme.ui.bg_m1 },
    PmenuThumb = { bg = theme.ui.bg_p2 },
  }
end

local config = {
  overrides = color_overrides
}

return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup(config)
    vim.cmd.colorscheme("kanagawa")
  end
}
