require("neoscroll").setup({})

local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "128" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "128" } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "256" } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "256" } }
t["<C-y>"] = { "scroll", { "-3", "false", "64" } }
t["<C-e>"] = { "scroll", { "3", "false", "64" } }
t["zt"] = { "zt", { "64" } }
t["zz"] = { "zz", { "64" } }
t["zb"] = { "zb", { "64" } }

require("neoscroll.config").set_mappings(t)
