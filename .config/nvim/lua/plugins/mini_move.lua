return {
	"nvim-mini/mini.move",
	version = "*",
	event = "VeryLazy",
	opts = {
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = "<",
			right = ">",
			down = "<S-j>",
			up = "<S-k>",

			-- Move current line in Normal mode
			line_left = "<",
			line_right = ">",
			line_down = "<S-j>",
			line_up = "<S-k>",
		},
	},
}
