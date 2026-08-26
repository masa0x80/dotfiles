local utils = require("utils")

utils.map("x", "gsq", utils.quote_selection, { buffer = true, desc = "Quote lines" })
utils.map("x", "gsQ", utils.unquote_selection, { buffer = true, desc = "Unquote lines" })
