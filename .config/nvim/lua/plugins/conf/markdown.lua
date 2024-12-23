local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local ORDERED_LIST_PATTERN = "^%s*%d+[%.%)] $"
local TASK_PATTERN = "^%s*[-*+] %[[x ]%] $"

local function backspace()
	local row = vim.fn.line(".") - 1
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

	local cw = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
	local bs = vim.api.nvim_replace_termcodes("<C-h>", true, false, true)
	if string.match(line, UNORDERED_LIST_PATTERN) then
		vim.api.nvim_feedkeys(cw, "n", true)
	elseif string.match(line, ORDERED_LIST_PATTERN) or string.match(line, TASK_PATTERN) then
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
		go_curr_heading = "<C-g><C-u>",
		go_parent_heading = "<C-g><C-p>",
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

		map("i", "<CR>", function()
			local row = vim.fn.line(".") - 1
			local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

			local col = vim.fn.col("$") - 1

			local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

			if
				string.match(line, UNORDERED_LIST_PATTERN)
				or string.match(line, ORDERED_LIST_PATTERN)
				or string.match(line, TASK_PATTERN)
			then
				vim.api.nvim_buf_set_text(0, row, 0, row, col, { "" })
			else
				vim.api.nvim_feedkeys(key, "n", false)
			end
		end, opts)

		map("i", "<BS>", backspace, opts)
		map("i", "<C-h>", backspace, opts)
		map("i", "<Tab>", function()
			local row = vim.fn.line(".") - 1
			local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

			if
				string.match(line, string.sub(UNORDERED_LIST_PATTERN, 0, -2))
				or string.match(line, string.sub(ORDERED_LIST_PATTERN, 0, -2))
				or string.match(line, string.sub(TASK_PATTERN, 0, -2))
			then
				local ct = vim.api.nvim_replace_termcodes("<C-t>", true, false, true)
				vim.api.nvim_feedkeys(ct, "n", true)
				return
			end

			local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
			vim.api.nvim_feedkeys(tab, "n", true)
		end, opts)
		map("i", "<S-Tab>", function()
			local row = vim.fn.line(".") - 1
			local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

			if
				string.match(line, string.sub(UNORDERED_LIST_PATTERN, 0, -2))
				or string.match(line, string.sub(ORDERED_LIST_PATTERN, 0, -2))
				or string.match(line, string.sub(TASK_PATTERN, 0, -2))
			then
				if string.sub(line, 0, 1) ~= " " then
					return
				end
				local cd = vim.api.nvim_replace_termcodes("<C-d>", true, false, true)
				vim.api.nvim_feedkeys(cd, "n", true)
				return
			end

			local tab = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
			vim.api.nvim_feedkeys(tab, "n", true)
		end, opts)
	end,
})
