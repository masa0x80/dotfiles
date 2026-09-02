local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	-- カーソル位置と `modified` を保ったままundo履歴を破棄
	local function clear_undo()
		local levels = vim.bo.undolevels
		local modified = vim.bo.modified
		local view = vim.fn.winsaveview()

		-- `undolevels`が-1の間に変更するとundo履歴が消える
		vim.bo.undolevels = -1
		vim.cmd([[silent! execute "normal! a \<BS>\<Esc>"]])
		vim.bo.undolevels = levels

		vim.bo.modified = modified
		vim.fn.winrestview(view)
	end

	local function full_path(name)
		return vim.fn.resolve(vim.fn.fnamemodify(name, ":p"))
	end

	-- バッファー変更せず暗号化して書き出す
	local function write_encrypted(lines, path)
		local cmd = { vim.o.shell, vim.o.shellcmdflag, "_en" }
		local result = vim.system(cmd, { stdin = table.concat(lines, "\n") .. "\n" }):wait()
		if result.code ~= 0 then
			vim.notify(
				("暗号化に失敗しました: %s\n%s"):format(path, result.stderr or ""),
				vim.log.levels.ERROR,
				{ title = "age" }
			)
			return false
		end

		local encrypted = vim.split(result.stdout, "\n", { plain = true })
		-- writefileが各行に改行を付けるので、末尾の空要素を消す
		if encrypted[#encrypted] == "" then
			table.remove(encrypted)
		end

		if vim.fn.writefile(encrypted, path) ~= 0 then
			vim.notify(("書き込みに失敗しました: %s"):format(path), vim.log.levels.ERROR, { title = "age" })
			return false
		end

		return true
	end

	require("utils").create_autocmd({ "BufReadPre", "FileReadPre" }, {
		pattern = "*.age.*",
		callback = function()
			vim.opt.eventignore:append("FileType")
		end,
	})

	require("utils").create_autocmd({ "BufReadPre", "BufNewFile" }, {
		pattern = "*.age.*",
		callback = function()
			-- 復号した平文のundo履歴がディスクに残らないように
			vim.bo.undofile = false
		end,
	})

	require("utils").create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age.*",
		callback = function(args)
			if args.event == "BufReadPost" then
				vim.cmd("silent %!_de")
			else
				-- :rの場合は、読み込んだ範囲だけを複合し、読み込みごと1回のundoで戻せるようにまとめる
				vim.cmd("silent! undojoin")
				vim.cmd("silent '[,']!_de")
			end

			vim.opt.eventignore:remove("FileType")
			vim.cmd("filetype detect")

			if args.event == "BufReadPost" then
				-- 復号前の暗号文がundoで現れないように
				clear_undo()
				vim.bo.modified = false
			end
		end,
	})

	require("utils").create_autocmd("BufWriteCmd", {
		pattern = "*.age.*",
		callback = function(args)
			local bufnr = args.buf
			local buf_path = full_path(vim.api.nvim_buf_get_name(bufnr))
			local path = args.match ~= "" and full_path(args.match) or buf_path
			-- :w {file} のように別名へ書き出す場合はバッファーの状態を変えない
			local own_file = path == buf_path

			-- BufWriteCmdを定義するとBufWritePre/BufWritePostが発火しなくなるので自前対応
			vim.api.nvim_exec_autocmds("User", { pattern = "AgeEncryptPre", data = { bufnr = bufnr } })
			vim.api.nvim_exec_autocmds("BufWritePre", { buffer = bufnr })

			local written = write_encrypted(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), path)
			if written and own_file then
				vim.bo[bufnr].modified = false
			end

			vim.api.nvim_exec_autocmds("User", { pattern = "AgeEncryptPost", data = { bufnr = bufnr } })
			if written then
				vim.api.nvim_exec_autocmds("BufWritePost", { buffer = bufnr })
			end
		end,
	})

	require("utils").create_autocmd("FileWriteCmd", {
		pattern = "*.age.*",
		callback = function(args)
			-- :{range}wで書き出された範囲だけ暗号化
			local first = vim.fn.line("'[")
			local last = vim.fn.line("']")
			local lines = vim.api.nvim_buf_get_lines(args.buf, first - 1, last, false)

			write_encrypted(lines, vim.fn.fnamemodify(args.match, ":p"))
		end,
	})
end
