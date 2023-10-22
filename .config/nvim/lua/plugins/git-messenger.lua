return {
	"rhysd/git-messenger.vim",
	keys = {
		{ "<C-g><C-l>", desc = "Show Git Log" },
	},
	config = require("config.utils").load("conf/git-messenger"),
	init = require("config.utils").load("init/git-messenger"),
}
