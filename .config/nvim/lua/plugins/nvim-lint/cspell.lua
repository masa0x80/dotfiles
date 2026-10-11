-- ref.
--   - https://zenn.dev/kawarimidoll/articles/ad35f3dc4a5009
--   - https://zenn.dev/kawarimidoll/articles/2e99432d27eda3

local cspell_config_dir = vim.fn.expand("$XDG_CONFIG_HOME/cspell")
local cspell_data_dir = vim.fn.expand("$XDG_DATA_HOME/cspell")
local dotfiles_local_dir = vim.fn.expand("$HOME/.config.local/cspell")
local cspell_files = {
	config = cspell_config_dir .. "/cspell.json",
	dotfiles = cspell_config_dir .. "/dotfiles.txt",
	dotfiles_local = dotfiles_local_dir .. "/local.txt",
	user = cspell_data_dir .. "/user.txt",
	lua = cspell_data_dir .. "/lua.txt",
	ruby = cspell_data_dir .. "/ruby.txt",
	vim = cspell_data_dir .. "/vim.txt",
}

-- 辞書ファイルがなければ空ファイルを作成
for _, path in ipairs({ cspell_files.user, cspell_files.dotfiles_local }) do
	if vim.fn.filereadable(path) ~= 1 then
		vim.fn.mkdir(vim.fs.dirname(path), "p")
		io.close(io.open(path, "a"))
	end
end

-- 辞書がなければダウンロード
local dict_base_url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries"
for _, name in ipairs({ "vim", "ruby", "lua" }) do
	local path = cspell_files[name]
	if vim.fn.filereadable(path) ~= 1 then
		vim.fn.mkdir(cspell_data_dir, "p")
		vim.system({ "curl", "-fsSLo", path, ("%s/%s/dict/%s.txt"):format(dict_base_url, name, name) })
	end
end

local dictionary_keys = {
	global = "dotfiles",
	["local"] = "dotfiles_local",
	user = "user",
}

local function cspell_append(opts)
	local target = opts.fargs[1]
	local dictionary_name = dictionary_keys[target] or "user"

	local word = opts.fargs[2]
	if not word or word == "" then
		-- 引数がなければcwordを取得
		word = vim.fn.expand("<cword>"):lower()
	end
	if word == "" then
		vim.notify("No word to append.", vim.log.levels.WARN, {})
		return
	end

	-- 辞書ファイルに追記
	local f = io.open(cspell_files[dictionary_name], "a")
	if not f then
		vim.notify("Failed to open " .. cspell_files[dictionary_name], vim.log.levels.ERROR, {})
		return
	end
	f:write(word .. "\n")
	f:close()

	-- 追加した単語および辞書を表示
	vim.notify('"' .. word .. '" is appended to ' .. dictionary_name .. " dictionary.", vim.log.levels.INFO, {})

	-- cspellをリロードするため、現在行を更新してすぐ戻す
	if vim.bo.modifiable then
		vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
		vim.cmd("silent! undo")
	end
end

vim.api.nvim_create_user_command("CSpellAppend", cspell_append, { nargs = "*" })
for key, target in pairs({ g = "global", l = "local", u = "user" }) do
	require("utils").map("n", "<Leader>a" .. key, "<Cmd>CSpellAppend " .. target .. "<CR>")
end

vim.api.nvim_create_user_command("OpenCSpellDotfile", "edit " .. cspell_files.dotfiles, {})
vim.api.nvim_create_user_command("OpenCSpellLocal", "edit " .. cspell_files.dotfiles_local, {})
vim.api.nvim_create_user_command("OpenCSpellUser", "edit " .. cspell_files.user, {})
