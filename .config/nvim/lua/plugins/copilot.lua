return {
	{
		"zbirenbaum/copilot.lua",
		version = "*",
		cmd = "Copilot",
		ft = { "gitcommit", "jjdescription" },
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = {
					["*"] = false,
					gitcommit = true,
					jjdescription = true,
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		version = "*",
		opts = {
			window = {
				layout = "float",
				width = 0.8,
				height = 0.8,
				border = "rounded",
			},
			show_help = true,
		},
		build = "make tiktoken",
		event = "VeryLazy",
		keys = {
			{
				"<Leader>cc",
				function()
					vim.ui.input({
						prompt = "CopilotChat: ",
						default = "",
					}, function(text)
						if text == nil or text == "" then
							return
						else
							vim.cmd("CopilotChat " .. text)
						end
					end)
				end,
				desc = "CopilotChat",
				mode = { "n", "v" },
			},
			{ "<Leader>ce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code", mode = { "n", "v" } },
			{ "<Leader>cf", "<Cmd>CopilotChatFix<CR>", desc = "CopilotChat - Fix code", mode = { "n", "v" } },
			{ "<Leader>ct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests", mode = { "n", "v" } },
			{ "<Leader>cr", "<Cmd>CopilotChatReview<CR>", desc = "CopilotChat - Review code", mode = { "n", "v" } },
			{ "<Leader>cR", "<Cmd>CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code", mode = { "n", "v" } },
		},
	},
}
