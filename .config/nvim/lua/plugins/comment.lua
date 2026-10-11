return {
	{
		"numToStr/Comment.nvim",
		version = "*",
		event = { "VeryLazy" },
		init = function()
			-- gc/gccもComment.nvim経由にする
			for _, a in ipairs({
				{ "gc", "n", "comment_toggle_linewise", "Toggle comment" },
				{ "gc", "x", "comment_toggle_linewise_visual", "Toggle comment" },
				{
					"gcc",
					"n",
					function()
						return vim.v.count == 0 and "comment_toggle_linewise_current" or "comment_toggle_linewise_count"
					end,
					"Toggle comment line",
				},
				{ "\\\\", "n", "comment_toggle_linewise_current", "Toggle line-comment" },
				{ "\\\\", "x", "comment_toggle_linewise_visual", "Toggle line-comment" },
				{ "\\<C-b>", "n", "comment_toggle_blockwise_current", "Toggle block-comment" },
				{ "\\<C-b>", "x", "comment_toggle_blockwise_visual", "Toggle block-comment" },
			}) do
				local lhs, mode, target, desc = a[1], a[2], a[3], a[4]

				local rhs = function()
					local ok, undo_glow = pcall(require, "undo-glow")
					if ok then
						vim.g.ug_ignore_cursor_moved = true
						undo_glow.highlight_changes({ hlgroup = "UgComment" })
					end

					return "<Plug>(" .. (type(target) == "function" and target() or target) .. ")"
				end

				vim.keymap.set(mode, lhs, rhs, { expr = true, remap = true, desc = desc })
			end
		end,
		config = function()
			local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

			-- ```ts のような拡張子表記もfiletypeに寄せる
			local function to_filetype(lang)
				if type(require("Comment.ft").get(lang)) == "table" then
					return lang
				end

				return vim.filetype.match({ filename = "x." .. lang })
			end

			-- lnum行を含むコードブロックの言語を返す
			-- plantumlなどtreesitterのパーサーがないものはinfo stringから拾う
			local function fenced_filetype(lnum)
				if vim.bo.filetype ~= "markdown" then
					return nil
				end

				local fence, lang
				for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, lnum - 1, false)) do
					local backticks, info = line:match("^%s*(```+)(.*)$")
					if fence then
						if backticks and #backticks >= #fence and info:match("^%s*$") then
							fence, lang = nil, nil
						end
					elseif backticks then
						fence, lang = backticks, info:lower():match("^%s*([%w_+#%-]+)")
					end
				end

				return lang and to_filetype(lang) or nil
			end

			require("Comment").setup({
				mappings = { basic = false, extra = false },
				pre_hook = function(ctx)
					local ok, cstr = pcall(ts_pre_hook, ctx)
					if ok and cstr then
						return cstr
					end

					local ft = fenced_filetype(ctx.range.srow) or vim.bo.filetype

					return require("Comment.ft").get(ft, ctx.ctype) or vim.bo.commentstring
				end,
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		version = "*",
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},
}
