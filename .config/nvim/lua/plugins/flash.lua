return {
	"folke/flash.nvim",
	version = "*",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		labels = "fjdksla;ghtyrueiwoqpbnvmc,x.z/",
	},
	-- stylua: ignore
	keys = {
		{ "ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
		{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
		{
			"<Leader><Space>",
			mode = { "n", "o", "x" },
			function()
				require("flash").jump({
				  search = { mode = "search", max_length = 0 },
				  label = { after = false, before = {0, 0} },
				  pattern = "^",
				})
			end,
			desc = "Jump to a line"
		},
	},
}
