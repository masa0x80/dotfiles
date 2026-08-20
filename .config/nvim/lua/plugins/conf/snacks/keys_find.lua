local conf = require("plugins.conf.snacks")

local function find_opts(order, cwd)
	return { cwd = cwd, sort = { fields = { "file:" .. order } } }
end

local function all_files(order, cwd)
	Snacks.picker.files(vim.tbl_extend("force", find_opts(order, cwd), {
		hidden = true,
		ignored = true,
	}))
end

local function recent(root)
	Snacks.picker.recent({
		filter = {
			cwd = true,
			paths = {
				[root .. "/.git/COMMIT_EDITMSG"] = false,
			},
		},
	})
end

return {
	{
		"<Leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<Leader>b",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<Leader>fc",
		function()
			Snacks.picker.git_files({
				cwd = os.getenv("DOTFILES_DIR"),
				untracked = true,
				hidden = true,
				ignored = true,
			})
		end,
		desc = "Find Dotfiles",
	},
	{
		"<Leader>ff",
		function()
			conf.smart_files(find_opts("desc"))
		end,
		desc = "Find Files",
	},
	{
		"<Leader>fr",
		function()
			conf.smart_files(find_opts("asc"))
		end,
		desc = "Find Files (rev)",
	},
	{
		"<Leader>F",
		function()
			all_files("desc")
		end,
		desc = "Find Git Files",
	},
	{
		"<Leader>R",
		function()
			all_files("asc")
		end,
		desc = "Find Git Files (rev)",
	},
	{
		"<C-;>ff",
		function()
			conf.smart_files(find_opts("desc", conf.telekasten_home()))
		end,
		desc = "Find Git Files (under Telekasten home)",
	},
	{
		"<C-;>fr",
		function()
			conf.smart_files(find_opts("asc", conf.telekasten_home()))
		end,
		desc = "Find Git Files (under Telekasten home; rev)",
	},
	{
		"<C-;>F",
		function()
			all_files("desc", conf.telekasten_home())
		end,
		desc = "Find Files (under Telekasten home)",
	},
	{
		"<C-;>R",
		function()
			all_files("asc", conf.telekasten_home())
		end,
		desc = "Find Files (under Telekasten home; rev)",
	},
	{
		"<Leader>fl",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<Leader>re",
		function()
			recent(conf.git_root_or_cwd())
		end,
		desc = "Recent",
	},
	{
		"<Leader>RE",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},
	{
		"<C-;>re",
		function()
			recent(conf.telekasten_home())
		end,
		desc = "Recent (under Telekasten home)",
	},
	{
		"<C-;>RE",
		function()
			Snacks.picker.recent({ filter = { cwd = conf.telekasten_home() } })
		end,
		desc = "Recent (under Telekasten home)",
	},
}
