return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "VeryLazy",
		enabled = function()
			return vim.bo.filetype ~= "prompt" and vim.b.completion ~= false
		end,
		opts = {
			cmdline = { enabled = false },
			keymap = { preset = "enter" },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		snippets = { preset = "luasnip" },
		opts_extend = { "sources.default" },
	},
	{
		"rafamadriz/friendly-snippets",
	},
	{
		"L3MON4D3/LuaSnip",
	},
}
