return {
	"nvim-mini/mini.move",
	version = "*",
	event = "VeryLazy",
	opts = {
		mappings = {
			left = "H",
			right = "L",
			down = "J",
			up = "K",

			line_left = "<C-g><C-h>",
			line_right = "<C-g><C-l>",
			line_down = "<C-g><C-j>",
			line_up = "<C-g><C-k>",
		},
	},
}
