return {
	"norcalli/nvim-colorizer.lua",
	event = { "CursorHold", "CursorMoved", "ModeChanged" },
	config = require("config.utils").load("conf/nvim-colorizer"),
}
