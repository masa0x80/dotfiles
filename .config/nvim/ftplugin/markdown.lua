local utils = require("utils")

utils.map("x", "gsq", utils.quote_selection, { buffer = true, desc = "Quote lines" })
utils.map("x", "gsQ", utils.unquote_selection, { buffer = true, desc = "Unquote lines" })

-- コードフェンスの中身も折り畳めるようにする
require("misc.markdown_fold").reset(vim.api.nvim_get_current_buf())
vim.opt_local.foldexpr = "v:lua.require'misc.markdown_fold'.foldexpr()"
