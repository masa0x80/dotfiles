local path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
vim.api.nvim_create_user_command("StartPlantUmlServer", function()
	local msg = vim.fn.system("docker compose -f " .. path .. " up -d")
	if vim.v.shell_error ~= 0 then
		vim.notify(vim.fn.substitute(msg, "\n$", "", ""), "error", { render = "default", timeout = 10000 })
	end
end, {})

vim.api.nvim_create_user_command("StopPlantUmlServer", function()
	vim.fn.jobstart("docker compose -f " .. path .. " down")
end, {})

vim.api.nvim_create_user_command("MarkdownPreviewWrapper", function()
	vim.fn.execute("StartPlantUmlServer")
	vim.fn.execute("MarkdownPreview")
end, {})

vim.opt_local.foldlevel = 1
