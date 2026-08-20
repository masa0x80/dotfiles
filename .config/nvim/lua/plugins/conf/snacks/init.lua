local M = {}

M.git_root_or_cwd = function()
	return require("snacks.git").get_root() or vim.fn.getcwd()
end

-- TelekastenのVaultのパス
M.telekasten_home = function()
	return require("telekasten").Cfg.home
end

M.dir_prompt = function(default, cb)
	default = default or vim.fn.getcwd()
	vim.ui.input({
		prompt = "Directory: ",
		default = vim.fn.fnamemodify(default, ":~") .. "/",
		completion = "dir",
	}, function(input)
		if input == nil or vim.trim(input) == "" then
			return
		end
		local dir = vim.fn.expand(vim.trim(input))
		if vim.fn.isdirectory(dir) == 0 then
			Snacks.notify.error("Not a directory: `" .. dir .. "`")
			return
		end
		cb(vim.fs.normalize(vim.fn.fnamemodify(dir, ":p")))
	end)
end

-- Git管理化ならgit_files、そうでなければfilesを使う
-- @param opts? table additional options (cwd, sort, etc.)
M.smart_files = function(opts)
	opts = opts or {}
	local root = require("snacks.git").get_root()
	if root == nil then
		Snacks.picker.files(vim.tbl_deep_extend("force", {
			hidden = true,
			ignored = true,
		}, opts))
	else
		Snacks.picker.git_files(vim.tbl_deep_extend("force", {
			untracked = true,
		}, opts))
	end
end

return M
