local c = require("config.color")
local set_hl = vim.api.nvim_set_hl

set_hl(0, "CmpItemAbbrDeprecated", { fg = c.green, bg = "NONE", strikethrough = true })
set_hl(0, "CmpItemAbbrMatch", { fg = c.blue, bg = "NONE", bold = true })
set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.blue, bg = "NONE", bold = true })
set_hl(0, "CmpItemMenu", { fg = c.purple, bg = "NONE", italic = true })

set_hl(0, "CmpItemKindField", { fg = c.fg, bg = c.dark_red })
set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindField" })
set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

set_hl(0, "CmpItemKindText", { fg = c.black, bg = c.green })
set_hl(0, "CmpItemKindEnum", { link = "CmpItemKindText" })
set_hl(0, "CmpItemKindKeyword", { link = "CmpItemKindText" })

set_hl(0, "CmpItemKindConstant", { fg = c.black, bg = c.yellow })
set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })
set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })

set_hl(0, "CmpItemKindFunction", { fg = c.black, bg = c.purple })
set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindClass", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindModule", { link = "CmpItemKindFunction" })
set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindFunction" })

set_hl(0, "CmpItemKindVariable", { fg = c.fg, bg = c.grey })
set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

set_hl(0, "CmpItemKindUnit", { fg = c.black, bg = c.dark_yellow })
set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindUnit" })
set_hl(0, "CmpItemKindFolder", { link = "CmpItemKindUnit" })

set_hl(0, "CmpItemKindMethod", { fg = c.black, bg = c.blue })
set_hl(0, "CmpItemKindValue", { link = "CmpItemKindMethod" })
set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindMethod" })

set_hl(0, "CmpItemKindInterface", { fg = c.black, bg = c.cyan })
set_hl(0, "CmpItemKindColor", { link = "CmpItemKindInterface" })
set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindInterface" })
