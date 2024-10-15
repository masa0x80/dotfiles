return {
	"rasulomaroff/cursor.nvim",
	event = "Colorscheme",
	opts = {
		cursors = {
			{
				mode = { "n", "v" },
				-- NOTE: blinking times don't affect cursor blinking times,
				-- ref. https://github.com/rasulomaroff/cursor.nvim?tab=readme-ov-file#terminals
				blink = 10,
			},
			{
				mode = { "i" },
				shape = "ver",
				size = 100,
				-- NOTE: blinking times don't affect cursor blinking times,
				-- ref. https://github.com/rasulomaroff/cursor.nvim?tab=readme-ov-file#terminals
				blink = 10,
			},
		},
	},
}
