-- conform.nvim 用の独自フォーマッター定義（lualine では非表示扱い）
return {
	delete_jira_status_icon = {
		command = "sed",
		args = {
			("s|\\[!\\[\\](%s.*)\\(.*\\)\\](\\(\\S*\\))[  ]-[  ]\\(.*\\)[  ][^  ]*[  ]\\?|[\\1 \\3](\\2)|g"):format(
				vim.fn.expand("$JIRA_BASE_URL"):gsub("/browse", "")
			),
		},
		stdin = true,
	},
	space_around_links = {
		command = "sed",
		args = (function()
			local open = "「『【（｛［〈《({[<｀'\"`\u{2018}\u{201c}"
			local close = "」』】）｝］〉》)}]>｀'\"`\u{2019}\u{201d}"
			local punct1 = "。、！？―〜＝：\\-~="
			local punct2 = "。、！？―〜＝：\\-~=,\\.!?:"
			local link = "\\[([^][]|[\\\\][][])*\\]\\([^)]*\\)"
			return {
				"-E",
				-- リンク前にスペース（画像リンクと記号は除く）
				("s/([^ \t!%s%s])(%s)/\\1 \\2/g; "):format(open, punct1, link)
					-- 画像前にスペース
					.. ("s/([^ \t%s%s])(!%s)/\\1 \\2/g; "):format(open, punct1, link)
					-- リンク・画像の後ろにスペース（記号は除く）
					.. ("s/(!?%s)([^ \t%s%s])/\\1 \\3/g"):format(link, close, punct2),
			}
		end)(),
		stdin = true,
	},
	injected = {},
}
