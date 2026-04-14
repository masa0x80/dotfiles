local compose_path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
local tmp_dir = "/tmp/plantuml-viewer/"
local port = 8765

local preview_bufnr = nil

-- NOTE: dangerouslySetInnerHTML では <script> は実行されないけど <img onerror> は実行される
local image_zoom_script =
	[[<img src='_' onerror="if(!window._imgClick){window._imgClick=true;document.addEventListener('click',function(e){var t=e.target;if(t.tagName==='IMG'){t.classList.toggle('enlarged')}else{document.querySelectorAll('img.enlarged').forEach(function(i){i.classList.remove('enlarged')})}})}" style="display:none">]]

local function remove_preview_script(bufnr)
	local first = vim.api.nvim_buf_get_lines(bufnr, 0, 2, false)
	if #first > 2 and first[1] == image_zoom_script and first[2] == "" then
		vim.api.nvim_buf_set_lines(bufnr, 0, 2, false, {})
	elseif #first > 1 and first[1] == image_zoom_script then
		vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, {})
	end
end

local function cleanup_preview()
	if not preview_bufnr then
		return
	end

	local bufnr = preview_bufnr
	preview_bufnr = nil

	pcall(vim.api.nvim_del_augroup_by_name, "MarkdownPreview")

	if vim.api.nvim_buf_is_valid(bufnr) then
		remove_preview_script(bufnr)
		vim.bo[bufnr].modified = false
	end
end

local function start_plantuml_server()
	vim.system({ "docker", "compose", "-f", compose_path, "up", "-d" }, { text = true }, function(obj)
		if obj.code ~= 0 then
			vim.notify(tostring(obj.code), "error", { render = "default", timeout = 10000 })
		end
	end)
end

local function stop_plantuml_server()
	vim.system({ "docker", "compose", "-f", compose_path, "down" })
end

local function write_svg()
	local filepath = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t")
	local outfile = tmp_dir .. "out.svg"
	vim.system({
		"curl",
		"-s",
		"-H",
		"Content-Type: application/text; charset=UTF-8",
		"--data-binary",
		"@" .. filepath,
		("http://localhost:%d/svg/"):format(port),
	}, { text = true }, function(obj)
		if obj.code ~= 0 then
			return
		end
		local f = io.open(outfile, "w")
		if not f then
			return
		end
		f:write(obj.stdout)
		f:close()
		vim.uv.fs_copyfile(outfile, tmp_dir .. filename .. ".svg")
	end)
end

vim.api.nvim_create_user_command("StartPlantUmlServer", start_plantuml_server, {})
vim.api.nvim_create_user_command("StopPlantUmlServer", stop_plantuml_server, {})

vim.api.nvim_create_user_command("MarkdownPreviewWrapper", function()
	start_plantuml_server()

	cleanup_preview()

	-- プレビュー用の加工
	local bufnr = vim.fn.bufnr()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	table.insert(lines, 1, image_zoom_script)
	table.insert(lines, 2, "")
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.bo[bufnr].modified = false

	vim.cmd("MarkdownPreview")

	preview_bufnr = bufnr
	local group_id = vim.api.nvim_create_augroup("MarkdownPreview", { clear = true })

	-- BufWritePreでスクリプトを消す
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = group_id,
		buffer = bufnr,
		callback = function()
			if not preview_bufnr then
				return
			end

			remove_preview_script(bufnr)
		end,
	})

	-- BufWritePOstでスクリプトを再度挿入
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = group_id,
		buffer = bufnr,
		callback = function()
			if not preview_bufnr then
				return
			end

			local cur = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			table.insert(cur, 1, image_zoom_script)
			table.insert(cur, 2, "")
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, cur)
			vim.bo[bufnr].modified = false
		end,
	})

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
		group = group_id,
		buffer = bufnr,
		callback = function()
			cleanup_preview()
		end,
	})
	vim.api.nvim_create_autocmd({ "VimLeave" }, {
		group = group_id,
		callback = function()
			cleanup_preview()
		end,
	})
end, {})

vim.api.nvim_create_user_command("PlantUMLPreview", function()
	start_plantuml_server()
	local filename = vim.fn.expand("%:t")
	vim.fn.mkdir(tmp_dir, "p")
	write_svg()
	vim.uv.fs_copyfile(vim.fn.expand("$DOTFILE/etc/plantuml/viewer.html"), tmp_dir .. "viewer.html")
	-- 前回起動したプロセスが残っていたらkill
	local port2 = 8766
	vim.system({ "pkill", "-f", "python -m http.server " .. port2 }):wait()
	vim.system({ "python", "-m", "http.server", port2, "--directory", tmp_dir })
	vim.system({
		"open",
		"-n",
		"-a",
		vim.fn.expand("$TARGET_BROWSER"),
		"--args",
		("http://localhost:%d/viewer.html?filename=%s"):format(port2, filename),
	})
	local group = vim.api.nvim_create_augroup("PlantUMLPreview:" .. filename, { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = group,
		buffer = vim.fn.bufnr(),
		callback = write_svg,
	})
end, {})

require("utils").create_autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function(args)
		require("editorconfig").config(args.buf)
	end,
})
