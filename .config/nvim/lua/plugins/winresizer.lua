return {
	"simeji/winresizer",
	version = "*",
	keys = {
		{ "<C-g><C-r>", nil, desc = "WinResizer" },
	},
	init = require("utils").load("init/winresizer"),
}
