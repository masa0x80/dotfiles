local conf = require("plugins.conf.snacks")

local M = {}

local function expand_includes(vault_path, templates_dir)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for lnum, line in ipairs(lines) do
		-- (.-) は非貪欲なキャプチャーで `includes%s+` の後の文字列を取得する
		local ref = line:match("{{include%s+(.-)%s*}}")
		if ref then
			local path
			if ref:find("^/") then
				path = ref
			elseif ref:find("^~/") then
				path = vim.fn.expand(ref)
			elseif vim.fn.filereadable(templates_dir .. "/" .. ref) == 1 then
				path = templates_dir .. "/" .. ref
			else
				path = vault_path .. "/" .. ref
			end
			if vim.fn.filereadable(path) == 1 then
				local content = vim.fn.readfile(path)
				vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, content)
				return expand_includes()
			end
		end
	end
end

function M.apply()
	local vault_path = conf.telekasten_home()
	local templates_dir = vault_path .. "/templates"
	local files = vim.fn.glob(templates_dir .. "/**/*", false, true)
	local items = vim.iter(files)
		:filter(function(v)
			return vim.fn.filereadable(v) == 1
		end)
		:map(function(file)
			return { text = vim.fn.fnamemodify(file, ":."), file = file }
		end)
		:totable()

	Snacks.picker({
		title = "Apply template",
		items = items,
		format = function(item)
			return { { item.text } }
		end,
		preview = "file",
		confirm = function(picker, item)
			picker:close()
			if not item then
				return
			end
			vim.cmd("-1r " .. item.file)
			expand_includes(vault_path, templates_dir)

			local date = vim.fn.expand("%:t:r"):match("(%d%d%d%d%-%d%d%-%d%d)")
			vim.cmd(date and ("ReplaceDate " .. date) or "ReplaceDate")
			vim.api.nvim_exec_autocmds("User", { pattern = "TemplateApplied" })
			pcall(vim.cmd, "filetype detect")
		end,
	})
end

return M
