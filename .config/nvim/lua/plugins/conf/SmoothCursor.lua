require("smoothcursor").setup({
	type = "default",
	fancy = {
		enable = true,
		head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
		body = {
			{ cursor = "󰇙", texthl = "SmoothCursor" },
			{ cursor = "󱗼", texthl = "SmoothCursor" },
			{ cursor = "󱗼", texthl = "SmoothCursor" },
			{ cursor = "󱗼", texthl = "SmoothCursor" },
			{ cursor = "󰇙", texthl = "SmoothCursor" },
		},
	},
	speed = 32,
})

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "SmoothCursor", { fg = color.WHITE })

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "CursorHold", "CursorMoved", "ModeChanged" }, {
	callback = function()
		local current_mode = vim.fn.mode()
		if current_mode == "n" or current_mode == "" then
			vim.fn.sign_define("smoothcursor", { text = "󰇙" })
		elseif current_mode == "v" then
			vim.fn.sign_define("smoothcursor", { text = "" })
		elseif current_mode == "V" then
			vim.fn.sign_define("smoothcursor", { text = "" })
		elseif current_mode == "" then
			vim.fn.sign_define("smoothcursor", { text = "󰁁" })
		elseif current_mode == "i" then
			vim.fn.sign_define("smoothcursor", { text = "" })
		end
	end,
})
