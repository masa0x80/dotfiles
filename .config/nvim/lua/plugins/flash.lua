local jump = function(opts)
	opts = opts or {}

	require("flash").jump({
		search = { mode = "search", forward = opts.forward, wrap = opts.wrap, multi_window = opts.multi_window },
		label = { after = false, before = { 0, 0 }, uppercase = false },
		pattern = [[^]],
		action = function(match, state)
			state:hide()
			require("flash").jump({
				search = { max_length = 0 },
				highlight = { matches = false },
				matcher = function(win)
					-- limit matches to the current label
					return vim.tbl_filter(function(m)
						return m.label == match.label and m.win == win
					end, state.results)
				end,
				labeler = function(matches)
					for _, m in ipairs(matches) do
						m.label = m.label2 -- use the second label
					end
				end,
			})
		end,
		labeler = function(matches, state)
			local labels = state:labels()
			for m, match in ipairs(matches) do
				match.label1 = labels[math.floor((m - 1) / #labels) + 1]
				match.label2 = labels[(m - 1) % #labels + 1]
				match.label = match.label1
			end
		end,
	})
end

return {
	"folke/flash.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		labels = "fjdksla;ghtyrueiwoqpbnvmc,x.z/",
		modes = {
			treesitter = {
				labels = "fjdksla;ghtyrueiwoqpbnvmc,x.z/",
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<Leader><Space>",
			mode = { "n", "o", "x" },
			jump,
			desc = "Jump to a line",
		},
		{
			"<Leader>l",
			mode = { "n", "o", "x" },
			function()
				jump({ forward = true, wrap = false, multi_window = false })
			end,
			desc = "Jump to a line",
		},
		{
			"<Leader>h",
			mode = { "n", "o", "x" },
			function()
				jump({ forward = false, wrap = false, multi_window = false })
			end,
			desc = "Jump to a line",
		},
	},
}
