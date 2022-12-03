local status_ok, p = pcall(require, "gitsigns")
if not status_ok then
	return
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight link GitSignsCurrentLineBlame Comment",
})

p.setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 300,
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
		end, { expr = true })

		map("n", "[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map({ "n", "v" }, ",,s", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, ",,r", ":Gitsigns reset_hunk<CR>")
		map("n", ",,u", gs.undo_stage_hunk)
		map("n", ",,S", gs.stage_buffer)
		map("n", ",,R", gs.reset_buffer)
		map("n", ",,p", gs.preview_hunk)
		map("n", ",,d", gs.diffthis)
		map("n", ",,D", function()
			gs.diffthis("~")
		end)
		map("n", ",,td", gs.toggle_deleted)
		map("n", ",,tb", gs.toggle_current_line_blame)
		map("n", ",,b", function()
			gs.blame_line({ full = true })
		end)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>")
	end,
})
