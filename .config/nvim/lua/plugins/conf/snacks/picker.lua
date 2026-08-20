-- snacks.pickerのオプション
return {
	enabled = true,
	preview = function(ctx)
		local path = Snacks.picker.util.path(ctx.item)
		local ext = path and path:match("%.age%.(%w+)$")
		if ext then
			ctx.preview:set_title(vim.fn.fnamemodify(path, ":t"))
			local ft = vim.filetype.match({ filename = "x." .. ext }) or ext
			-- NOTE: ftを渡すとtermモードを使わないので `[Process exited 0]` が出ない
			return Snacks.picker.preview.cmd({ "_de", path }, ctx, {
				ft = ft,
				on_lines = function()
					ctx.preview:highlight({ ft = ft })
				end,
			})
		end
		return Snacks.picker.preview.file(ctx)
	end,
	win = {
		list = {
			keys = {
				["<C-j>"] = { "preview_scroll_down" },
				["<C-k>"] = { "preview_scroll_up" },
				["<C-y>"] = { "list_up" },
				["<C-e>"] = { "list_down" },
				["<C-f>"] = { "list_scroll_down" },
				["<C-b>"] = { "list_scroll_up" },
				["gi"] = { "toggle_focus" },
				["/"] = false,
			},
		},
		input = {
			keys = {
				["<C-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
				["<C-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
				["<C-a>"] = { "ctr_a", mode = { "i" } },
				["<C-f>"] = { "ctr_f", mode = { "i" } },
				["<C-b>"] = { "ctr_b", mode = { "i" } },
				-- NOTE: 別モードであっても同じKeyに対しての設定は後勝ちになってしまうので、Keyを明示する
				--       snacks.win が spec[1] を lhs として扱ってくれる
				list_scroll_down_n = { "<C-f>", "list_scroll_down", mode = { "n" } },
				list_scroll_up_n = { "<C-b>", "list_scroll_up", mode = { "n" } },
				["<C-z>"] = { "select_all", mode = { "n", "i" } },
				["<C-y>"] = { "yank", mode = { "n", "i" } },
				["<C-l>"] = { "show_full_path", mode = { "n", "i" } },
				["<C-o>"] = { "change_cwd", mode = { "n", "i" } },
			},
		},
	},
	actions = {
		ctr_a = function()
			vim.fn.execute("normal I")
		end,
		ctr_f = function()
			vim.fn.execute("normal l")
		end,
		ctr_b = function()
			vim.fn.execute("normal h")
		end,
		show_full_path = function(picker)
			local item = picker:current()
			if item and item.file then
				vim.notify(item.file, vim.log.levels.INFO)
			end
		end,
		change_cwd = function(picker)
			require("plugins.conf.snacks").dir_prompt(picker:cwd(), function(dir)
				picker:set_cwd(dir)
				picker:find({ refresh = true })
			end)
		end,
	},
	formatters = { file = { truncate = 128 } },
}
