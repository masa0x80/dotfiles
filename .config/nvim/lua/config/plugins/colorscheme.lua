vim.cmd.colorscheme("onedark")

require("config.plugins.colorscheme_custom")

local set_hl = vim.api.nvim_set_hl

-- noice.nvim: fix NoiceLspProgressTitle
set_hl(0, "NonText", { fg = CommentGrey })

-- git-conflict
set_hl(0, "GitConflictCurrentLabel", { fg = Black, bg = Green })
set_hl(0, "GitConflictIncomingLabel", { fg = Black, bg = Blue })
set_hl(0, "GitConflictAncestorLabel", { fg = Black, bg = White })

-- gitsigns
set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6d8086" })
