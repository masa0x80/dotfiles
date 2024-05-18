local builtin = require("statuscol.builtin")
require("statuscol").setup({
	setopt = true,
	relculright = true,
	segments = {
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
		{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	},
})
