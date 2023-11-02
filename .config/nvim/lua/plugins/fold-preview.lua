return {
	"anuvyklack/fold-preview.nvim",
	-- NOTE: VeryLazyだと初期化がうまく行かない場合がある
	event = "CursorHold",
	config = require("config.utils").load("conf/fold-preview"),
	dependencies = {
		"anuvyklack/pretty-fold.nvim",
	},
}
