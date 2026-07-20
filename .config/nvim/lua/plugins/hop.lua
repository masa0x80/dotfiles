return {
	"smoka7/hop.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		local hop = require("hop")
		hop.setup({})

		local map = require("utils").map
		map("", "<CR><CR>", function()
			hop.hint_vertical()
		end, {})
	end,
}
