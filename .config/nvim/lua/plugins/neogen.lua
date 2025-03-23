return {
	"danymat/neogen",
	version = "*",
	opts = {},
	keys = {
		{
			"<Leader>dF",
			"<Cmd>lua require('neogen').generate({ type = 'file' })<CR>",
			noremap = true,
			silent = true,
			desc = "neogen: file",
		},
		{
			"<Leader>df",
			"<Cmd>lua require('neogen').generate({ type = 'func' })<CR>",
			noremap = true,
			silent = true,
			desc = "neogen: func",
		},
		{
			"<Leader>dc",
			"<Cmd>lua require('neogen').generate({ type = 'class' })<CR>",
			noremap = true,
			silent = true,
			desc = "neogen: class",
		},
		{
			"<Leader>dt",
			"<Cmd>lua require('neogen').generate({ type = 'type' })<CR>",
			noremap = true,
			silent = true,
			desc = "neogen: type",
		},
	},
	config = require("config.utils").load("conf/neogen"),
}
