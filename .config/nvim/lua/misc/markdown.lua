if vim.fn.executable("markdown2confluence") == 1 then
	vim.api.nvim_create_user_command("Md2Confluence", function()
		local out = "/tmp/" .. vim.fn.strftime("%FT%T") .. ".confluence"
		vim.fn.execute("%y")
		vim.fn.execute("edit " .. out)
		vim.fn.execute("put!")
		vim.fn.execute("write")
		vim.fn.execute("0read !cat " .. out .. " | markdown2confluence")
		vim.fn.execute((vim.fn.line(".") + 1) .. ",$d")
		vim.fn.execute("%y")
	end, {})
end

local path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
vim.api.nvim_create_user_command("StartPlantUmlServer", function()
	vim.system(
		{ "docker", "compose", "-f", vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml"), "up", "-d" },
		{ text = true },
		function(obj)
			if obj.code ~= 0 then
				vim.notify(tostring(obj.code), "error", { render = "default", timeout = 10000 })
			end
		end
	)
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
	-- nvim終了時にpythonも終了するために `jobstart` を利用
	vim.fn.jobstart("python -m http.server " .. port .. " --directory " .. tmp_dir)
	vim.system({
		"open",
		"-n",
		"-a",
		vim.fn.expand("$BROWSER"),
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
