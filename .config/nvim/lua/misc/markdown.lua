local compose_path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
local tmp_dir = "/tmp/plantuml-viewer/"
local port = 8765

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
	vim.cmd("MarkdownPreview")
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
	require("utils").create_autocmd({ "BufWritePost" }, {
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
