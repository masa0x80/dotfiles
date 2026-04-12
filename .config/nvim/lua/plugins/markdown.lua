return {
	{
		"tadmccorkle/markdown.nvim",
		version = "*",
		ft = { "markdown" },
		config = function()
			local UNORDERED_LIST_PATTERN = "^%s*[-*+][ >]*$"
			local ORDERED_LIST_PATTERN = "^%s*%d+[%.%)][ >]*$"
			local TASK_PATTERN = "^%s*[-*+] %[[x%- ]%] $"
			local QUOTED_PATTERN = "^%s*>[ >]+$"

			local function backspace()
				local row = vim.fn.line(".") - 1
				local col = vim.fn.col("$") - 1
				local indent = vim.fn.indent(".")
				local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

				local bs = vim.api.nvim_replace_termcodes("<C-h>", true, false, true)
				if string.match(line, UNORDERED_LIST_PATTERN) then
					if col == indent + 2 then
						print(col .. " " .. indent)
						vim.api.nvim_buf_set_text(0, row, indent, row, col, { "" })
					else
						vim.api.nvim_buf_set_text(0, row, indent, row, col, { "- " })
					end
				elseif string.match(line, ORDERED_LIST_PATTERN) then
					print(col .. " " .. indent)
					if col == indent + 3 then
						vim.api.nvim_buf_set_text(0, row, indent, row, col, { "" })
					else
						vim.api.nvim_buf_set_text(0, row, indent, row, col, { "1. " })
					end
				elseif string.match(line, TASK_PATTERN) then
					vim.api.nvim_buf_set_text(0, row, indent, row, col, { "- " })
				elseif string.match(line, QUOTED_PATTERN) then
					vim.api.nvim_buf_set_text(0, row, indent, row, col, { "" })
				else
					vim.api.nvim_feedkeys(bs, "n", true)
				end
			end

			require("markdown").setup({
				mappings = {
					inline_surround_toggle = "gs",
					inline_surround_toggle_line = "gss",
					inline_surround_delete = "ds",
					inline_surround_change = "cs",
					link_add = "gl",
					link_follow = false,
					go_curr_heading = "[s",
					go_parent_heading = "[S",
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
						local col = vim.fn.col("$") - 1
						local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

						local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

						if
							string.match(line, UNORDERED_LIST_PATTERN)
							or string.match(line, ORDERED_LIST_PATTERN)
							or string.match(line, TASK_PATTERN)
						then
							vim.api.nvim_buf_set_text(0, row, 0, row, col, { "" })
						else
							vim.api.nvim_feedkeys(cr, "n", false)
						end
					end, opts)

					map("i", "<BS>", backspace, opts)
					map("i", "<C-h>", backspace, opts)
				end,
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		version = "*",
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				render_modes = { "n" },
				heading = {
					position = "inline",
					icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
					signs = { "󰉴" },
				},
				code = {
					border = "thin",
					position = "right",
					width = "block",
				},
				bullet = {
					icons = { "󱠦" },
					highlight = "MarkdownBullet",
				},
				checkbox = {
					unchecked = {
						icon = "󰄱",
					},
					checked = {
						icon = "󰄵",
					},
					custom = {
						todo = {
							raw = "[-]",
							rendered = "󰡖",
							highlight = "@markup.list.in_progress",
						},
					},
				},
				pipe_table = {
					style = "normal",
				},
				html = {
					comment = {
						text = "…snip…",
					},
				},
				win_options = {
					concealcursor = {
						default = vim.api.nvim_get_option_value("concealcursor", {}),
						rendered = "",
					},
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		version = "*",
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		ft = { "markdown", "mermaid", "plantuml" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown", "mermaid", "plantuml" }
			vim.g.mkdp_theme = "light"
			vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/markdown-preview/markdown.css")
			local default_options = {
				disable_sync_scroll = true,
				uml = {
					server = "http://127.0.0.1:8765",
					imageFormat = "svg",
				},
			}
			vim.g.mkdp_preview_options = default_options

			vim.api.nvim_create_user_command("EnableMDPScroll", function()
				vim.g.mkdp_preview_options =
					vim.tbl_deep_extend("force", default_options, { disable_sync_scroll = false })
			end, {})
			vim.api.nvim_create_user_command("DisableMDPScroll", function()
				vim.g.mkdp_preview_options =
					vim.tbl_deep_extend("force", default_options, { disable_sync_scroll = true })
			end, {})
		end,
	},
}
