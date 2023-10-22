return {
	"simeji/winresizer",
	keys = {
		{ "<M-r>", nil, desc = "Winresizer" },
	},
	init = require("config.utils").load("init/winresizer"),
}
