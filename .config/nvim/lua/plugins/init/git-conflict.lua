local c = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "GitConflictCurrentLabel", { fg = c.black, bg = c.green })
set_hl(0, "GitConflictIncomingLabel", { fg = c.black, bg = c.blue })
set_hl(0, "GitConflictAncestorLabel", { fg = c.black, bg = c.fg })
