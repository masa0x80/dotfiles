local conf = require("plugins.conf.snacks")

local grep_opts = {
	hidden = true,
	args = { "--pre=_de", "--pre-glob=*.age.*" },
}

-- TelekastenのVault配下を対象に
local function telekasten_grep_opts()
	return vim.tbl_extend("force", grep_opts, { cwd = conf.telekasten_home })
end

return {
	{
		"<Leader>/",
		function()
			Snacks.picker.grep(grep_opts)
		end,
		desc = "Grep",
	},
	{
		"<Leader>sB",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	-- Grep
	{
		"<Leader>sg",
		function()
			Snacks.picker.grep(grep_opts)
		end,
		desc = "Grep",
	},
	{
		"<Leader>sG",
		function()
			Snacks.picker.grep_word(grep_opts)
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	{
		"<Leader>G",
		function()
			Snacks.picker.grep_word(grep_opts)
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	{
		"<C-;>sg",
		function()
			Snacks.picker.grep(telekasten_grep_opts())
		end,
		desc = "Grep (under Telekasten home)",
	},
	{

		"<C-;>sG",
		function()
			Snacks.picker.grep_word(telekasten_grep_opts())
		end,
		mode = { "n", "x" },
		desc = "Visual selection or word (under Telekasten home)",
	},
	{

		"<C-;>G",
		function()
			Snacks.picker.grep_word(telekasten_grep_opts())
		end,
		mode = { "n", "x" },
		desc = "Visual selection or word (under Telekasten home)",
	},
}
