require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 0,
		ignore_whitespace = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]g", function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Gitsigns: next_hunk" })

		map("n", "[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Gitsigns: prev_hunk" })

		-- Actions
		map({ "n", "v" }, ",,s", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns: stage_hunk" })
		map({ "n", "v" }, ",,r", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns: reset_hunk" })
		map("n", ",,u", gs.undo_stage_hunk, { desc = "Gitsigns: undo_stage_hunk" })
		map("n", ",,S", gs.stage_buffer, { desc = "Gitsigns: stage_buffer" })
		map("n", ",,R", gs.reset_buffer, { desc = "Gitsigns: reset_buffer" })
		map("n", ",,p", gs.preview_hunk, { desc = "Gitsigns: preview_hunk" })
		map("n", ",,d", gs.diffthis, { desc = "Gitsigns: diffthis" })
		map("n", ",,D", function()
			gs.diffthis("~")
		end, { desc = "Gitsigns: diffthis('~')" })
		map("n", ",,td", gs.toggle_deleted, { desc = "Gitsigns: toggle_deleted" })
		map("n", ",,tb", gs.toggle_current_line_blame, { desc = "Gitsigns: toggle_current_line_blame" })
		map("n", ",,b", function()
			gs.blame_line({ full = true })
		end, { desc = "Gitsigns: blame_line" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { desc = "Gitsigns: select_hunk" })
	end,
})
