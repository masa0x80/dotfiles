local search_keys = {}
for lhs, fn in pairs({ n = "search_next", N = "search_prev", ["*"] = "search_star", ["#"] = "search_hash" }) do
	table.insert(search_keys, {
		lhs,
		function()
			require("undo-glow")[fn]({
				animation = {
					animation_type = "strobe",
				},
			})
		end,
		mode = "n",
		desc = "Highlight " .. fn:gsub("_", " "),
		noremap = true,
	})
end

return {
	"y3owk1n/undo-glow.nvim",
	version = "*",
	event = { "VeryLazy" },
	dependencies = {
		{ "catppuccin/nvim", version = "*" },
	},
	---@type UndoGlow.Config
	opts = function()
		local palette = require("catppuccin.palettes").get_palette("macchiato")

		return {
			animation = {
				enabled = true,
				duration = 300,
				animation_type = "zoom",
				window_scoped = true,
			},
			-- 透過背景だとアニメーションの色計算ができないのでフォールバックを指定
			fallback_for_transparency = {
				bg = palette.base,
				fg = palette.text,
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
		}
	end,
	keys = vim.list_extend({
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
			"gc",
			function()
				require("undo-glow").comment_textobject()
			end,
			mode = "o",
			desc = "Comment textobject with highlight",
			noremap = true,
		},
	}, search_keys),
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
