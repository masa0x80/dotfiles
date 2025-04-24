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
			system_prompt = [[
				あなたはプロのソフトウェアエンジニアであり、以下のルールに従ってください：
				- コードの説明は簡潔かつ技術的に正確にしてください
				- 常に実践的なアドバイスを提供してください
				- バグの可能性やエッジケースを指摘してください
				- 質問に直接答え、余計な説明は避けてください
			]],
			prompts = {
				Explain = "このコードを詳細に説明してください。 #buffer",
				Review = [[
					このコードをレビューしてください。以下の点に注目してください：
					1. パフォーマンスの問題
					2. 脆弱性
					3. コードの可読性とベストプラクティス
					4. エラーハンドリング
					5. リファクタリングの提案
					#buffer
				]],
				Tests = "このコードの動作について簡潔に説明し、単体テストを作成してください。 #buffer",
				Refactor = "このコードをより明確で読みやすいものに改善してください。 #buffer",
				Fix = "このコードのエラーや問題を修正してください。 #buffer",
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
