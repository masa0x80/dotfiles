local up = vim.api.nvim_replace_termcodes("<Up>", true, false, true)
local down = vim.api.nvim_replace_termcodes("<Down>", true, false, true)

return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"fang2hou/blink-copilot",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		enabled = function()
			return vim.bo.filetype ~= "prompt" and vim.b.completion ~= false
		end,
		opts = {
			cmdline = {
				keymap = {
					preset = "super-tab",
					["<C-CR>"] = { "show", "show_documentation", "hide_documentation" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = { menu = { auto_show = true } },
			},
			keymap = {
				preset = "super-tab",
				["<C-CR>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-n>"] = {
					function(cmp)
						if not cmp.is_menu_visible() then
							vim.api.nvim_feedkeys(down, "n", true)
						end
					end,
					"select_next",
					"fallback_to_mappings",
				},
				["<C-p>"] = {
					function(cmp)
						if not cmp.is_menu_visible() then
							vim.api.nvim_feedkeys(up, "n", true)
						end
					end,
					"select_prev",
					"fallback_to_mappings",
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				menu = {
					border = "rounded",
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local lspkind = require("lspkind")
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									elseif ctx.kind == "Copilot" then
										icon = ""
									else
										icon = lspkind.symbolic(ctx.kind)
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = function()
					if vim.bo.filetype == "markdown" then
						return { "lsp", "snippets", "path" }
					else
						return { "lsp", "snippets", "buffer", "path", "copilot" }
					end
				end,
				-- NOTE: Neovim補完プラグインblink.cmpの使い方とカスタマイズ https://eiji.page/blog/neovim-blink-cmp-intro/
				min_keyword_length = function(ctx)
					-- :wq, :qa -> menu doesn't popup
					-- :Lazy, :wqa -> menu popup
					if ctx.mode == "cmdline" and ctx.line:find("^%l+$") ~= nil then
						return 3
					end
					return 0
				end,
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
