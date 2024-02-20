require("neoscroll").setup({
	mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "64" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "64" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "128" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "128" } }
t["zt"] = { "zt", { "32" } }
t["zz"] = { "zz", { "32" } }
t["zb"] = { "zb", { "32" } }

require("neoscroll.config").set_mappings(t)
