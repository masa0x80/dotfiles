local vault = require("plugins.conf.vault")
local util = require("plugins.conf.todo_util")
local toggle_todo = util.toggle_todo
local toggle_check = util.toggle_check
local get_lines = util.get_lines

-- x モードでは選択行すべてに適用する
local function each_line(toggle, opts)
	return function()
		local lines = get_lines()
		for n = lines[1], lines[2] do
			toggle(vim.tbl_extend("force", opts, { linenr = n }))
		end
	end
end

local toggle_keys = {}
for _, t in ipairs({
	{ lhs = "<C-g><C-i>", toggle = toggle_check, opts = { skip_progress = true }, desc = "Toggle check" },
	{
		lhs = "<C-g><C-o>",
		toggle = toggle_check,
		opts = { skip_progress = true, reverse = true },
		desc = "Toggle check",
	},
	{ lhs = "<C-g><C-g><C-i>", toggle = toggle_todo, opts = {}, desc = "Toggle todo" },
	{ lhs = "<C-g><C-g><C-o>", toggle = toggle_todo, opts = { reverse = true }, desc = "Toggle todo" },
}) do
	table.insert(toggle_keys, {
		t.lhs,
		function()
			t.toggle(t.opts)
		end,
		mode = { "n", "i" },
		desc = t.desc,
	})
	table.insert(toggle_keys, { t.lhs, each_line(t.toggle, t.opts), mode = "x", desc = t.desc })
end

-- ノートのバッファに設定されるデフォルトのキーマップ。既存のキーマップ（mini.align, dial, mini.bracketed）と衝突するので削除する
local default_buffer_keys = { "<CR>", "<C-a>", "<C-x>", "]o", "[o", "]l", "[l" }

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	-- NOTE: ft = "markdown" で遅延読み込みすると、最初のバッファで BufEnter を逃して LSP が起動しないので、
	--       Vault 内のファイルを読む前に読み込む
	event = vault.events(vault.default_home()),
	cmd = { "Obsidian" },
	keys = vim.list_extend({
		{ "<C-;>z", "<Cmd>Obsidian<CR>", desc = "Obsidian commands" },
		{ "<C-;>i", vault.insert_link, desc = "Obsidian insert_link" },
		{ "<C-;>I", vault.insert_img_link, desc = "Obsidian insert_img_link" },
		{ "<C-;>l", vault.follow_link, desc = "Obsidian follow_link" },
		{ "<C-;>b", vault.show_backlinks, desc = "Show backlinks" },
		{ "<C-;>n", "<Cmd>Obsidian rename<CR>", desc = "Obsidian rename" },
		{ "<C-;>T", "<Cmd>Obsidian tags<CR>", desc = "Obsidian tags" },
		{ "<C-;>d", vault.goto_today, desc = "Goto today" },
		{ "<C-;>w", vault.goto_thisweek, desc = "Goto this week" },
		{ "<C-;>m", vault.goto_thismonth, desc = "Goto this month" },
		{ "<C-;>v", "<Cmd>Obsidian workspace<CR>", desc = "Obsidian workspace" },
		{
			"<C-;><C-t>",
			function()
				vim.fn.setreg("+", ("%s/%s.md"):format(vim.fn.expand("%:.:h"), os.date("%Y-%m-%d")))
				vault.new_templated_note()
			end,
			desc = "New templated note",
		},
	}, toggle_keys),
	init = function()
		local todo_mark_patterns = {
			"- \\[[x -]\\] [0-9][0-9]:[0-9][0-9]–[0-9][0-9]:[0-9][0-9] ",
			"- \\[[x -]\\] <.*> ",
			"- \\[[x -]\\] ",
		}
		vim.api.nvim_create_user_command("DeleteTodoMark", function(o)
			local range = o.range == 0 and "%" or (o.line1 .. "," .. o.line2)
			for _, pattern in ipairs(todo_mark_patterns) do
				pcall(vim.cmd, range .. "s/" .. pattern .. "/- /g")
			end
			vim.cmd.nohlsearch()
		end, {
			range = 2,
		})

		require("utils").create_autocmd("User", {
			pattern = "ObsidianNoteEnter",
			callback = function(ev)
				for _, lhs in ipairs(default_buffer_keys) do
					pcall(vim.keymap.del, "n", lhs, { buffer = ev.buf })
				end
			end,
		})
	end,
	opts = {
		legacy_commands = false,
		workspaces = {
			{ name = "scrapbook", path = vault.default_home() },
		},
		picker = { name = "snacks.picker" },

		-- Vault のノートには frontmatter がないので付けない
		frontmatter = { enabled = false },
		-- 表示は render-markdown.nvim に任せる
		ui = { enable = false },
		footer = { enabled = false },
		statusline = { enabled = false },

		-- ノートはタイトルをそのままファイル名にして Vault 直下に作る
		new_notes_location = "notes_subdir",
		note_id_func = function(title)
			return title or os.date("%Y%m%d%H%M%S")
		end,
		-- Obsidian の設定 (newLinkFormat = absolute) に合わせて Vault からのパスでリンクする
		link = {
			style = "wiki",
			format = "absolute",
		},

		-- デイリーノートとテンプレートは plugins.conf.vault / plugins.conf.snacks.template で扱う
		daily_notes = { enabled = false },
		templates = { enabled = false },
	},
}
