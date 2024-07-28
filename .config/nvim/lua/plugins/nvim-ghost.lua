return {
	"subnut/nvim-ghost.nvim",
	cmd = "GhostTextStart",
	init = function()
		vim.g.nvim_ghost_autostart = 0
	end,
	keys = {
		{
			"<C-k><C-k>",
			function()
				vim.notify("GhostTextStart")
				vim.cmd("GhostTextStart")
				vim.keymap.del("n", "<C-k><C-k>")
			end,
			desc = "GhostTextStart",
		},
	},
}
