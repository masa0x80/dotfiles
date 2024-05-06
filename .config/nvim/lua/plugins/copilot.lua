return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("config.utils").load("conf/copilot"),
	},
	{
		"jellydn/CopilotChat.nvim",
		opts = {
			mode = "split",
			prompts = {
				Explain = "Explain how it works.",
				Review = "Review the following code and provide concise suggestions.",
				Tests = "Briefly explain how the selected code works, then generate unit tests.",
				Refactor = "Refactor the code to improve clarity and readability.",
			},
		},
		build = function()
			vim.defer_fn(function()
				vim.cmd("UpdateRemotePlugins")
				vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
			end, 3000)
		end,
		event = "VeryLazy",
		keys = {
			{
				"<Leader>ccc",
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
			},
			{ "<leader>cce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
			{ "<leader>cct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
			{ "<leader>ccr", "<Cmd>CopilotChatReview<CR>", desc = "CopilotChat - Review code" },
			{ "<leader>ccR", "<Cmd>CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code" },
		},
	},
}
