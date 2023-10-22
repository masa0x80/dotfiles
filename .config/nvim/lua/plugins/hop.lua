return {
	"smoka7/hop.nvim",
	keys = {
		{ "<Leader><Space>", "<Cmd>HopWord<CR>", noremap = true, silent = true },
	},
	config = require("config.utils").load("conf/hop"),
}
