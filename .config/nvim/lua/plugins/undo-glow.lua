local palette = require("catppuccin.palettes").get_palette("macchiato")

return {
	"y3owk1n/undo-glow.nvim",
	version = "*",
	event = { "VeryLazy" },
	---@type UndoGlow.Config
	opts = {
		animation = {
			enabled = true,
			duration = 300,
			animation_type = "zoom",
			window_scoped = true,
		},
		highlights = {
			undo = {
				hl_color = { bg = palette.red },
			},
			redo = {
				hl_color = { bg = palette.green },
			},
			yank = {
				hl_color = { bg = palette.yellow },
			},
			paste = {
				hl_color = { bg = palette.peach },
			},
			search = {
				hl_color = { bg = palette.mauve },
			},
			comment = {
				hl_color = { bg = palette.teal },
			},
			cursor = {
				hl_color = { bg = palette.sky },
			},
		},
		priority = 2048 * 3,
	},
	keys = {
		{
			"u",
			function()
				require("undo-glow").undo()
			end,
			mode = "n",
			desc = "Undo with highlight",
			noremap = true,
		},
		{
			"U",
			function()
				require("undo-glow").redo()
			end,
			mode = "n",
			desc = "Redo with highlight",
			noremap = true,
		},
		{
			"p",
			function()
				require("undo-glow").paste_below()
				vim.cmd.normal({ args = { "`]" }, bang = true })
			end,
			mode = "n",
			desc = "Paste below with highlight",
			noremap = true,
		},
		{
			"P",
			function()
				require("undo-glow").paste_above()
				vim.cmd.normal({ args = { "`]" }, bang = true })
			end,
			mode = "n",
			desc = "Paste above with highlight",
			noremap = true,
		},
		{
			"n",
			function()
				require("undo-glow").search_next({
					animation = {
						animation_type = "strobe",
					},
				})
			end,
			mode = "n",
			desc = "Search next with highlight",
			noremap = true,
		},
		{
			"N",
			function()
				require("undo-glow").search_prev({
					animation = {
						animation_type = "strobe",
					},
				})
			end,
			mode = "n",
			desc = "Search prev with highlight",
			noremap = true,
		},
		{
			"*",
			function()
				require("undo-glow").search_star({
					animation = {
						animation_type = "strobe",
					},
				})
			end,
			mode = "n",
			desc = "Search star with highlight",
			noremap = true,
		},
		{
			"#",
			function()
				require("undo-glow").search_hash({
					animation = {
						animation_type = "strobe",
					},
				})
			end,
			mode = "n",
			desc = "Search hash with highlight",
			noremap = true,
		},
		{
			"gc",
			function()
				-- This is an implementation to preserve the cursor position
				local pos = vim.fn.getpos(".")
				vim.schedule(function()
					vim.fn.setpos(".", pos)
				end)
				return require("undo-glow").comment()
			end,
			mode = { "n", "x" },
			desc = "Toggle comment with highlight",
			expr = true,
			noremap = true,
		},
		{
			"gc",
			function()
				require("undo-glow").comment_textobject()
			end,
			mode = "o",
			desc = "Comment textobject with highlight",
			noremap = true,
		},
		{
			"gcc",
			function()
				return require("undo-glow").comment_line()
			end,
			mode = "n",
			desc = "Toggle comment line with highlight",
			expr = true,
			noremap = true,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("TextYankPost", {
			desc = "Highlight when yanking (copying) text",
			callback = function()
				require("undo-glow").yank()
			end,
		})

		-- This only handles neovim instance and do not highlight when switching panes in tmux
		vim.api.nvim_create_autocmd("CursorMoved", {
			desc = "Highlight when cursor moved significantly",
			callback = function()
				require("undo-glow").cursor_moved({
					animation = {
						animation_type = "slide",
					},
				})
			end,
		})

		-- This will handle highlights when focus gained, including switching panes in tmux
		vim.api.nvim_create_autocmd("FocusGained", {
			desc = "Highlight when focus gained",
			callback = function()
				---@type UndoGlow.CommandOpts
				local opts = {
					animation = {
						animation_type = "slide",
					},
				}

				opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
				local pos = require("undo-glow.utils").get_current_cursor_row()

				require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
					s_row = pos.s_row,
					s_col = pos.s_col,
					e_row = pos.e_row,
					e_col = pos.e_col,
					force_edge = opts.force_edge == nil and true or opts.force_edge,
				}))
			end,
		})

		vim.api.nvim_create_autocmd("CmdlineLeave", {
			desc = "Highlight when search cmdline leave",
			callback = function()
				require("undo-glow").search_cmd({
					animation = {
						animation_type = "fade",
					},
				})
			end,
		})
	end,
}
