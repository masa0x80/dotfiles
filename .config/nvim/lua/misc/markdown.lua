local path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
vim.api.nvim_create_user_command("StartPlantUmlServer", function()
	vim.system({ "docker", "compose", "-f", path, "up", "-d" }, { text = true }, function(obj)
		if obj.code ~= 0 then
			vim.notify(tostring(obj.code), "error", { render = "default", timeout = 10000 })
		end
	end)
end, {})

vim.api.nvim_create_user_command("StopPlantUmlServer", function()
	vim.system({ "docker", "compose", "-f", path, "down" })
end, {})

vim.api.nvim_create_user_command("MarkdownPreviewWrapper", function()
	vim.fn.execute("StartPlantUmlServer")
	vim.fn.execute("MarkdownPreview")
end, {})

local tmp_dir = "/tmp/plantuml-viewer/"
local port = "8766"
local function writeSvg()
	local filename = vim.fn.expand("%:t")
	vim.fn.jobstart(
		"curl -H 'Content-Type: application/text; charset=UTF-8' --data-binary @"
			.. vim.fn.expand("%")
			.. " 'http://127.0.0.1:8765/svg/' > "
			.. tmp_dir
			.. "out.svg",
		{
			on_exit = function()
				vim.system({ "cp", tmp_dir .. "out.svg", tmp_dir .. filename .. ".svg" })
			end,
		}
	)
end

vim.api.nvim_create_user_command("PlantUMLPreview", function()
	vim.fn.execute("StartPlantUmlServer")
	local filename = vim.fn.expand("%:t")
	vim.system({ "mkdir", "-p", tmp_dir })
	writeSvg()
	vim.system({ "cp", vim.fn.expand("$DOTFILE/etc/plantuml/viewer.html"), tmp_dir })
	-- 前回起動したプロセスが残っていたらkill
	vim.system({ "pkill", "python", "-m", "http.server", port, "--directory", tmp_dir }):wait()
	vim.system({ "python", "-m", "http.server", port, "--directory", tmp_dir })
	vim.system({
		"open",
		"-n",
		"-a",
		vim.fn.expand("$TARGET_BROWSER"),
		"--args",
		"http://localhost:" .. port .. "/viewer.html?filename=" .. filename,
	})
	local group = "PlantUMLPreview:" .. filename
	vim.api.nvim_create_augroup(group, { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = group,
		buffer = vim.fn.bufnr(),
		callback = writeSvg,
	})
end, {})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function(args)
		require("editorconfig").config(args.buf)
	end,
})
