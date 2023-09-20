local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

M.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

return M
