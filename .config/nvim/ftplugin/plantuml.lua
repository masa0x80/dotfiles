local path = vim.fn.expand("$DOTFILE/etc/plantuml/docker-compose.yml")

vim.api.nvim_create_user_command("StartPlantUmlServer", function()
	vim.fn.system("docker compose -f " .. path .. " up -d")
end, {})

vim.api.nvim_create_user_command("StopPlantUmlServer", function()
	vim.fn.jobstart("docker compose -f " .. path .. " down")
end, {})

vim.api.nvim_create_user_command("PlantUmlPreview", function()
	vim.fn.execute("StartPlantUmlServer")
	vim.fn.execute("MarkdownPreview")
end, {})
