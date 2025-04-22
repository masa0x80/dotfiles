return {
	{
		"zbirenbaum/copilot.lua",
		version = "*",
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("config.utils").load("conf/copilot"),
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		version = "*",
		opts = {
			prompts = {
				Explain = "このコードがどのように動作するか日本語で説明してください。",
				Review = "このコードをレビューしてください。以下の点に注目してください：\n"
					.. "1. パフォーマンスの問題\n"
					.. "2. 脆弱性\n"
					.. "3. コードの可読性とベストプラクティス\n"
					.. "4. エラーハンドリング\n"
					.. "リファクタリングの提案",
				Tests = "このコードの動作について簡潔に説明し、単体テストを作成してください。",
				Refactor = "このコードをより明確で読みやすいものに改善してください。",
				FixCode = "このコードのエラーや問題を修正してください。",
			},
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
			{ "<Leader>cce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
			{ "<Leader>ccf", "<Cmd>CopilotChatFixCode<CR>", desc = "CopilotChat - Fix code" },
			{ "<Leader>cct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
			{ "<Leader>ccr", "<Cmd>CopilotChatReview<CR>", desc = "CopilotChat - Review code" },
			{ "<Leader>ccR", "<Cmd>CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code" },
		},
	},
}
