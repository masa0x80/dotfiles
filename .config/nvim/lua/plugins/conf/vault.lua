-- Obsidian Vault ($SCRAPBOOK_DIR) 向けの補助関数
-- obsidian.nvim にない、または挙動を変えたい機能をここで実装する
local M = {}

local media_extensions = { "png", "jpg", "bmp", "gif", "pdf", "mp4", "webm", "webp" }

-- デフォルトの Vault
M.default_home = function()
	return vim.fn.expand("$SCRAPBOOK_DIR")
end

-- 現在のバッファが属する obsidian.nvim の workspace（なければ選択中の workspace）のルート
M.home = function()
	if Obsidian and Obsidian.workspaces then
		local file = vim.api.nvim_buf_get_name(0)
		local ws = file ~= "" and require("obsidian.api").find_workspace(file) or Obsidian.workspace
		if ws then
			return tostring(ws.root)
		end
	end
	return M.default_home()
end

-- Vault 内の markdown を開く前に obsidian.nvim を読み込むためのイベント
M.events = function(dir)
	return { "BufReadPre " .. dir .. "/*.md", "BufNewFile " .. dir .. "/*.md" }
end

local function with_md(path)
	return vim.fn.fnamemodify(path, ":e") == "" and path .. ".md" or path
end

-- テンプレートを読み込んで {{date}} を置換したうえで新規バッファに挿入する
local function insert_template(name, date)
	local template = ("%s/templates/%s"):format(M.home(), name)
	if vim.fn.filereadable(template) == 0 then
		return
	end
	local lines = vim.tbl_map(function(line)
		return (line:gsub("{{date}}", date or os.date("%Y-%m-%d")))
	end, vim.fn.readfile(template))
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

-- テンプレートがあれば、置換せずにそのまま先頭に読み込む
local function read_template(name)
	local template = ("%s/templates/%s"):format(M.home(), name)
	if vim.fn.filereadable(template) == 1 then
		vim.cmd("0r " .. vim.fn.fnameescape(template))
	end
end

-- ファイルを開く。新規ファイルなら親ディレクトリを作ってから on_new を呼ぶ
local function open(path, on_new)
	local is_new = vim.fn.filereadable(path) == 0
	if is_new then
		vim.fn.mkdir(vim.fs.dirname(path), "p")
	end
	vim.cmd.edit(vim.fn.fnameescape(path))
	if is_new and on_new then
		on_new()
	end
end

-- from_dir から to_path への相対パス
local function relative_path(from_dir, to_path)
	local from = vim.split(vim.fs.normalize(from_dir), "/", { trimempty = true })
	local to = vim.split(vim.fs.normalize(to_path), "/", { trimempty = true })
	local i = 1
	while i <= #from and i <= #to and from[i] == to[i] do
		i = i + 1
	end
	local parts = {}
	for _ = i, #from do
		table.insert(parts, "..")
	end
	vim.list_extend(parts, to, i)
	return table.concat(parts, "/")
end

-- wiki link のリンク先のノートが Vault 内に存在するか
local function note_exists(location)
	local home = M.home()
	local name = with_md(location)
	for _, dir in ipairs({ home, vim.fn.expand("%:p:h") }) do
		if vim.fn.filereadable(dir .. "/" .. name) == 1 then
			return true
		end
	end
	-- Obsidian の shortest 形式のリンク（ファイル名のみ）
	if not location:find("/") then
		return #vim.fs.find(name, { path = home, type = "file", limit = 1 }) > 0
	end
	return false
end

-- リンク先を開く。wiki link のリンク先が存在しなければ確認せずに Vault 直下に作成する
M.follow_link = function()
	local link, kind = require("obsidian.api").cursor_link()
	local location = kind == "wiki" and link and link:match("^%[%[(.-)%]%]$")
	if location then
		-- [[note#heading|alias]] / [[note^block]] からノート部分だけ取り出す
		location = vim.trim(location:gsub("|.*$", ""):gsub("[#^].*$", ""))
	end
	if not location or location == "" or note_exists(location) then
		vim.cmd("Obsidian follow_link")
		return
	end
	open(M.home() .. "/" .. with_md(location))
end

-- ピッカーを閉じて元のウィンドウに戻ってから挿入する
local function put(text)
	vim.schedule(function()
		vim.api.nvim_put({ text }, "c", true, true)
	end)
end

-- Vault 内のノートを選んで [[path]] を挿入する
M.insert_link = function()
	Snacks.picker.files({
		title = "Insert link",
		cwd = M.home(),
		ft = "md",
		confirm = function(picker, item)
			picker:close()
			if item then
				local path = relative_path(M.home(), Snacks.picker.util.path(item))
				put(("[[%s]]"):format(path:gsub("%.md$", "")))
			end
		end,
	})
end

-- Vault 内の画像などを選んで、現在のファイルからの相対パスで ![](path) を挿入する
M.insert_img_link = function()
	Snacks.picker.files({
		title = "Insert image link",
		cwd = M.home(),
		ft = media_extensions,
		confirm = function(picker, item)
			picker:close()
			if item then
				put(("![](%s)"):format(relative_path(vim.fn.expand("%:p:h"), Snacks.picker.util.path(item))))
			end
		end,
	})
end

local function escape_regex(s)
	return (s:gsub("[%.%^%$%|%?%*%+%(%)%[%]%{%}\\]", "\\%0"))
end

-- 現在のノートへの wiki link（[[path]] / [[name]]、#heading や |alias 付きも含む）を grep する
M.show_backlinks = function()
	local file = vim.fn.expand("%:p")
	local path = relative_path(M.home(), file):gsub("%.md$", "")
	local name = vim.fn.fnamemodify(file, ":t:r")
	local targets = vim.tbl_map(escape_regex, path == name and { name } or { path, name })
	Snacks.picker.grep({
		title = "Backlinks",
		cwd = M.home(),
		search = ("\\[\\[(%s)([#|^][^\\]]*)?\\]\\]"):format(table.concat(targets, "|")),
		regex = true,
		live = false,
	})
end

M.goto_today = function()
	local date = os.date("%Y-%m-%d")
	open(("%s/daily/%s/%s.md"):format(M.home(), os.date("%Y"), date), function()
		insert_template("daily.md", date)
	end)
end

M.goto_thisweek = function()
	local week_of_month = math.floor((tonumber(os.date("%d")) - 1) / 7) + 1
	local path = ("%s/weekly/%s/%s-w%d.md"):format(M.home(), os.date("%Y"), os.date("%m"), week_of_month)
	open(path, function()
		read_template("weekly.md")
	end)
end

M.goto_thismonth = function()
	local path = ("%s/monthly/%s/%s.md"):format(M.home(), os.date("%Y"), os.date("%Y-%m"))
	open(path, function()
		read_template("monthly.md")
	end)
end

-- タイトルを入力して Vault 直下にノートを作り、テンプレートを選んで適用する
M.new_templated_note = function()
	vim.ui.input({ prompt = "New note: " }, function(title)
		title = title and vim.trim(title)
		if not title or title == "" then
			return
		end
		open(M.home() .. "/" .. with_md(title), function()
			require("plugins.conf.snacks.template").apply()
		end)
	end)
end

return M
