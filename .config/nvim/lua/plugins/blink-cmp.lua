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
					["<Tab>"] = { "show", "fallback" },
					["<CR>"] = { "accept", "fallback" },
				},
				completion = {
					menu = { auto_show = false },
					ghost_text = { enabled = false },
				},
			},
			keymap = {
				preset = "super-tab",
				["<C-CR>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = {
					"accept",
					"fallback",
				},
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
										icon = lspkind.symbol_map[ctx.kind]
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
						return { "lsp", "path", "copilot" }
					else
						return { "lsp", "snippets", "buffer", "path", "copilot" }
					end
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
