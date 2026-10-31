local conf = require("plugins.conf.snacks")
local kensaku = require("plugins.conf.snacks.kensaku")

local grep_opts = {
	hidden = true,
	args = { "--pre=_de", "--pre-glob=*.age.*" },
}

-- ObsidianのVault配下を対象に
local function vault_grep_opts()
	return vim.tbl_extend("force", grep_opts, { cwd = conf.vault_home() })
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
		"<Leader>k",
		function()
			kensaku.grep()
		end,
		desc = "Search by [K]ensaku",
	},
	{
		"<C-;>k",
		function()
			kensaku.grep({ cwd = conf.vault_home() })
		end,
		desc = "Kensaku (under Vault)",
	},
	{
		"<C-;>sg",
		function()
			Snacks.picker.grep(vault_grep_opts())
		end,
		desc = "Grep (under Vault)",
	},
	{

		"<C-;>sG",
		function()
			Snacks.picker.grep_word(vault_grep_opts())
		end,
		mode = { "n", "x" },
		desc = "Visual selection or word (under Vault)",
	},
	{

		"<C-;>G",
		function()
			Snacks.picker.grep_word(vault_grep_opts())
		end,
		mode = { "n", "x" },
		desc = "Visual selection or word (under Vault)",
	},
}
