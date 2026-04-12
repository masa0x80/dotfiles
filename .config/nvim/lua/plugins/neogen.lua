return {
	"danymat/neogen",
	version = "*",
	keys = {
		{
			"<Leader>dF",
			"<Cmd>lua require('neogen').generate({ type = 'file' })<CR>",
			desc = "neogen: file",
		},
		{
			"<Leader>df",
			"<Cmd>lua require('neogen').generate({ type = 'func' })<CR>",
			desc = "neogen: func",
		},
		{
			"<Leader>dc",
			"<Cmd>lua require('neogen').generate({ type = 'class' })<CR>",
			desc = "neogen: class",
		},
		{
			"<Leader>dt",
			"<Cmd>lua require('neogen').generate({ type = 'type' })<CR>",
			desc = "neogen: type",
		},
	},
	config = function()
		require("neogen").setup({})
	end,
}
