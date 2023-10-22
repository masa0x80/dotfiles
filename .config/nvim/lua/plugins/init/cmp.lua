local color = require("config.color")
local set_hl = vim.api.nvim_set_hl

set_hl(0, "CmpItemAbbrDeprecated", { fg = color.GREEN, bg = color.NONE, strikethrough = true })
set_hl(0, "CmpItemAbbrMatch", { fg = color.BLUE, bg = color.NONE, bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = color.BLUE, bg = color.NONE, bold = true })
set_hl(0, "CmpItemMenu", { fg = color.MAGENTA, bg = color.NONE, italic = true })

set_hl(0, "CmpItemKindField", { fg = color.WHITE, bg = color.DARK_RED })
set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

set_hl(0, "CmpItemKindText", { fg = color.BLACK, bg = color.GREEN })
set_hl(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
set_hl(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

set_hl(0, "CmpItemKindConstant", { fg = color.BLACK, bg = color.YELLOW })
set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

set_hl(0, "CmpItemKindFunction", { fg = color.BLACK, bg = color.MAGENTA })
set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

set_hl(0, "CmpItemKindVariable", { fg = color.WHITE, bg = color.GUTTER_GREY })
set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

set_hl(0, "CmpItemKindUnit", { fg = color.BLACK, bg = color.DARK_YELLOW })
set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
set_hl(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

set_hl(0, "CmpItemKindMethod", { fg = color.BLACK, bg = color.BLUE })
set_hl(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

set_hl(0, "CmpItemKindInterface", { fg = color.BLACK, bg = color.CYAN })
set_hl(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
