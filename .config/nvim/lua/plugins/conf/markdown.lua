local utils = require("config.utils")

local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local ORDERED_LIST_PATTERN = "^%s*%d+[%.%)] $"
local TASK_PATTERN = "^%s*[-*+] %[[x ]%] $"

local function cursor_pos()
	local cursor = vim.api.nvim_win_get_cursor(0) -- 1-based row, 0-based col
	local row = cursor[1] - 1
	local col = vim.fn.charcol("$") - 1
	return row, col
end
local function backspace()
	local row, col = cursor_pos()
	local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

	local cw = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
	local bs = vim.api.nvim_replace_termcodes("<C-h>", true, false, true)
	if string.match(str, UNORDERED_LIST_PATTERN) then
		vim.api.nvim_feedkeys(cw, "n", true)
	elseif string.match(str, ORDERED_LIST_PATTERN) or string.match(str, TASK_PATTERN) then
		vim.api.nvim_feedkeys(cw .. cw, "n", true)
	else
		vim.api.nvim_feedkeys(bs, "n", true)
	end
end

---@diagnostic disable-next-line: missing-fields
require("markdown").setup({
	mappings = {
		inline_surround_toggle = "gs",
		inline_surround_toggle_line = "gss",
		inline_surround_delete = "ds",
		inline_surround_change = "cs",
		link_add = "gl",
		link_follow = false,
		go_curr_heading = "<C-g><C-c>",
		go_parent_heading = "<C-g><C-u>",
		go_next_heading = "]]",
		go_prev_heading = "[[",
	},
	inline_surround = {
		emphasis = {
			key = "i",
			txt = "*",
		},
		strong = {
			key = "b",
			txt = "**",
		},
		strikethrough = {
			key = "s",
			txt = "~~",
		},
		code = {
			key = "c",
			txt = "`",
		},
	},
	link = {
		paste = {
			enable = false,
		},
	},
	toc = {
		omit_heading = "toc omit heading",
		omit_section = "toc omit section",
		markers = { "-" },
	},
	on_attach = function(bufnr)
		local map = vim.keymap.set
		local opts = { noremap = true, buffer = bufnr }
		map({ "n" }, "o", "<Cmd>MDListItemBelow<CR>", opts)
		map({ "n" }, "O", "<Cmd>MDListItemAbove<CR>", opts)
		map("i", "<BS>", backspace, opts)
		map("i", "<C-h>", backspace, opts)
		map("i", "<Tab>", function()
			local row, col = cursor_pos()
			local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

			local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
			if
				string.match(str, string.sub(UNORDERED_LIST_PATTERN, 0, -2))
				or string.match(str, string.sub(ORDERED_LIST_PATTERN, 0, -2))
				or string.match(str, string.sub(TASK_PATTERN, 0, -2))
			then
				utils.indent()
			else
				vim.api.nvim_feedkeys(tab, "n", true)
			end
		end, opts)
		map("i", "<S-Tab>", function()
			local row, col = cursor_pos()
			local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

			local tab = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
			if
				string.match(str, string.sub(UNORDERED_LIST_PATTERN, 0, -2))
				or string.match(str, string.sub(ORDERED_LIST_PATTERN, 0, -2))
				or string.match(str, string.sub(TASK_PATTERN, 0, -2))
			then
				utils.indent(false)
			else
				vim.api.nvim_feedkeys(tab, "n", true)
			end
		end, opts)
		map("i", "<CR>", function()
			local row, col = cursor_pos()
			local str = vim.api.nvim_buf_get_text(0, row, 0, row, col, {})[1]

			if
				string.match(str, UNORDERED_LIST_PATTERN)
				or string.match(str, ORDERED_LIST_PATTERN)
				or string.match(str, TASK_PATTERN)
			then
				vim.api.nvim_buf_set_text(0, row, 0, row, col, { "" })
				vim.fn.execute("startinsert!")
			else
				vim.fn.execute("MDListItemBelow")
			end
		end, opts)
	end,
})
