local M = {}

-- augroup for this config file
local augroup = vim.api.nvim_create_augroup("_", {})

-- wrapper function to use internal augroup
M.create_autocmd = function(event, opts)
	vim.api.nvim_create_autocmd(
		event,
		vim.tbl_extend("force", {
			group = augroup,
		}, opts)
	)
end

M.map = function(modes, lhs, rhs, opts)
	vim.keymap.set(
		modes,
		lhs,
		rhs,
		vim.tbl_extend("force", {
			noremap = true,
			silent = true,
		}, opts or {})
	)
end

M.preview = function(path)
	vim.fn.execute(string.format("!open '%s'", path))
end

local local_lua_dir = vim.fn.expand("$HOME") .. "/.config.local/nvim/lua/"

-- $HOME/.config.local/nvim/lua/ 配下に指定パスのファイルがあれば読み込む
M.load_if_exists = function(rel_path)
	local path = local_lua_dir .. rel_path
	if vim.fn.filereadable(path) == 1 then
		vim.fn.execute("luafile " .. path)
		return true
	end
	return false
end

-- $HOME/.config.local/nvim/lua/ 配下に同名モジュールがあればそちらを、なければ通常の require を読み込む
M.require = function(name)
	if not M.load_if_exists(string.gsub(name, "%.", "/") .. ".lua") then
		require(name)
	end
end

M.js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

M.hidden_formatters = {
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

return M
