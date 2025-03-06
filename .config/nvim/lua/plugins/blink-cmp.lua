return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "VeryLazy",
		enabled = function()
			return vim.bo.filetype ~= "prompt" and vim.b.completion ~= false
		end,
		opts = {
			cmdline = {
				keymap = {
					preset = "super-tab",
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
			},
			keymap = {
				preset = "super-tab",
				["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				menu = { border = "rounded" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "snippets", "path" },
				-- NOTE: Neovim補完プラグインblink.cmpの使い方とカスタマイズ https://eiji.page/blog/neovim-blink-cmp-intro/
				min_keyword_length = function(ctx)
					-- :wq, :qa -> menu doesn't popup
					-- :Lazy, :wqa -> menu popup
					if ctx.mode == "cmdline" and ctx.line:find("^%l+$") ~= nil then
						return 3
					end
					return 0
				end,
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"rafamadriz/friendly-snippets",
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
	},
}
