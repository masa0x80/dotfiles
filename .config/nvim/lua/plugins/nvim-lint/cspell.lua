-- ref.
--   - https://zenn.dev/kawarimidoll/articles/ad35f3dc4a5009
--   - https://zenn.dev/kawarimidoll/articles/2e99432d27eda3

local cspell_config_dir = vim.fn.expand("$XDG_CONFIG_HOME/cspell")
local cspell_data_dir = vim.fn.expand("$XDG_DATA_HOME/cspell")
local dotfiles_local_dir = vim.fn.expand("~/.config.local/cspell")
local cspell_files = {
	config = cspell_config_dir .. "/cspell.json",
	dotfiles = cspell_config_dir .. "/dotfiles.txt",
	dotfiles_local = dotfiles_local_dir .. "/local.txt",
	user = cspell_data_dir .. "/user.txt",
	lua = cspell_data_dir .. "/lua.txt",
	ruby = cspell_data_dir .. "/ruby.txt",
	vim = cspell_data_dir .. "/vim.txt",
}

-- dotfiles辞書がなければ作成
if vim.fn.filereadable(cspell_files.dotfiles) ~= 1 then
	io.popen("mkdir -p " .. cspell_data_dir)
	io.popen("touch " .. cspell_files.dotfiles)
end

-- 辞書がなければダウンロード
for _, v in ipairs({
	{
		file_path = cspell_files.vim,
		url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/vim/dict/vim.txt",
	},
	{
		file_path = cspell_files.ruby,
		url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/ruby/dict/ruby.txt",
	},
	{
		file_path = cspell_files.lua,
		url = "https://raw.githubusercontent.com/streetsidesoftware/cspell-dicts/main/dictionaries/lua/dict/lua.txt",
	},
}) do
	if vim.fn.filereadable(v.file_path) ~= 1 then
		io.popen("curl -fsSLo " .. v.file_path .. " --create-dirs " .. v.url)
	end
end

-- ユーザー辞書がなければ作成
if vim.fn.filereadable(cspell_files.user) ~= 1 then
	io.popen("mkdir -p " .. cspell_data_dir)
	io.popen("touch " .. cspell_files.user)
end

-- dotfiles.local辞書がなければ作成
if vim.fn.filereadable(cspell_files.dotfiles_local) ~= 1 then
	io.popen("mkdir -p " .. dotfiles_local_dir)
	io.popen("touch " .. cspell_files.dotfiles_local)
end

local cspell_append = function(opts)
	local target = opts.fargs[1]
	local dictionary_name = target == "global" and "dotfiles" or target == "local" and "local" or "user"

	local word = opts.fargs[2]
	if not word or word == "" then
		-- 引数がなければcwordを取得
		word = vim.fn.expand("<cword>"):lower()
	end

	-- shellのechoコマンドで辞書ファイルに追記
	io.popen("echo " .. word .. " >> " .. cspell_files[dictionary_name])

	-- 追加した単語および辞書を表示
	vim.notify('"' .. word .. '" is appended to ' .. dictionary_name .. " dictionary.", vim.log.levels.INFO, {})

	-- cspellをリロードするため、現在行を更新してすぐ戻す
	if vim.api.nvim_get_option_value("modifiable", {}) then
		vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
		vim.api.nvim_command("silent! undo")
	end
end

vim.api.nvim_create_user_command("CSpellAppend", cspell_append, { nargs = "*" })
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<Leader>ag", "<Cmd>CSpellAppend dotfiles<CR>", opts)
keymap("n", "<Leader>al", "<Cmd>CSpellAppend dotfiles_local<CR>", opts)
keymap("n", "<Leader>au", "<Cmd>CSpellAppend user<CR>", opts)

vim.api.nvim_create_user_command("OpenCSpellDotfile", "edit " .. cspell_files.dotfiles, {})
vim.api.nvim_create_user_command("OpenCSpellLocal", "edit " .. cspell_files.dotfiles_local, {})
vim.api.nvim_create_user_command("OpenCSpellUser", "edit " .. cspell_files.user, {})
