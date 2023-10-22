-- ref.
--   - https://zenn.dev/kawarimidoll/articles/ad35f3dc4a5009
--   -  https://zenn.dev/kawarimidoll/articles/2e99432d27eda3

local cspell_config_dir = vim.fn.expand("$XDG_CONFIG_HOME/cspell")
local cspell_data_dir = vim.fn.expand("$XDG_DATA_HOME/cspell")
local dotfiles_local_dir = vim.fn.expand("~/.config.local/cspell")
local cspell_files = {
	config = cspell_config_dir .. "/cspell.json",
	dotfiles = cspell_config_dir .. "/dotfiles.txt",
	dotfiles_local = dotfiles_local_dir .. "/local.txt",
	vim = cspell_data_dir .. "/vim.txt.gz",
	user = cspell_data_dir .. "/user.txt",
}

-- dotfiles辞書がなければ作成
if vim.fn.filereadable(cspell_files.dotfiles) ~= 1 then
	io.popen("mkdir -p " .. cspell_data_dir)
	io.popen("touch " .. cspell_files.dotfiles)
end

-- vim辞書がなければダウンロード
if vim.fn.filereadable(cspell_files.vim) ~= 1 then
	local vim_dictionary_url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
	io.popen("curl -fsSLo " .. cspell_files.vim .. " --create-dirs " .. vim_dictionary_url)
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
	local word = opts.args
	if not word or word == "" then
		-- 引数がなければcwordを取得
		word = vim.fn.expand("<cword>"):lower()
	end

	-- bangの有無で保存先を分岐
	local dictionary_name = opts.bang and "dotfiles" or "user"

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

vim.api.nvim_create_user_command("CSpellAppend", cspell_append, { nargs = "?", bang = true })
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<Leader>a", "<Cmd>CSpellAppend<CR>", opts)
keymap("n", "<Leader>A", "<Cmd>CSpellAppend!<CR>", opts)

vim.api.nvim_create_user_command("OpenCSpellDotfile", "edit " .. cspell_files.dotfiles, {})
vim.api.nvim_create_user_command("OpenCSpellLocal", "edit " .. cspell_files.dotfiles_local, {})
vim.api.nvim_create_user_command("OpenCSpellUser", "edit " .. cspell_files.user, {})
