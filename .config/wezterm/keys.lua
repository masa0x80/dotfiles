local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

M.keys = {
	{
		key = "Enter",
		mods = "SUPER",
		action = act.ToggleFullScreen,
	},

	{
		key = "v",
		mods = "SUPER",
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "f",
		mods = "SUPER",
		action = act.Search("CurrentSelectionOrEmptyString"),
	},

	{
		key = "-",
		mods = "SUPER",
		action = act.DecreaseFontSize,
	},
	{
		key = "0",
		mods = "SUPER",
		action = act.ResetFontSize,
	},
	{
		key = "=",
		mods = "SUPER",
		action = act.IncreaseFontSize,
	},
	{
		key = "n",
		mods = "SUPER",
		action = act.SpawnWindow,
	},

	-- ref. https://github.com/wez/wezterm/issues/3180
	{
		key = "/",
		mods = "CTRL",
		action = act({ SendString = "\x1f" }),
	},

	{
		key = "L",
		mods = "CTRL",
		action = act.ShowDebugOverlay,
	},

	{
		key = "u",
		mods = "SUPER",
		action = act.EmitEvent("toggle-opacity"),
	},

	{
		key = "j",
		mods = "SUPER",
		action = act.EmitEvent("open-bookmark"),
	},
}

M.key_tables = {
	copy_mode = {
		{ key = "Tab", action = act.CopyMode("MoveForwardWord") },
		{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "Enter", action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "Escape", action = act.CopyMode("Close") },
		{ key = "Space", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "$", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = ",", action = act.CopyMode("JumpReverse") },
		{ key = "0", action = act.CopyMode("MoveToStartOfLine") },
		{ key = ";", action = act.CopyMode("JumpAgain") },
		{ key = "F", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "G", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "H", action = act.CopyMode("MoveToViewportTop") },
		{ key = "L", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "M", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "O", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "T", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{ key = "V", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "^", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "A", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "b", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "E", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "e", action = act.CopyMode("MoveForwardWordEnd") },
		{ key = "e", mods = "CTRL", action = act.CopyMode("MoveDown") },
		{ key = "f", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
		{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
		{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
		{ key = "g", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "h", action = act.CopyMode("MoveLeft") },
		{ key = "j", action = act.CopyMode("MoveDown") },
		{ key = "k", action = act.CopyMode("MoveUp") },
		{ key = "l", action = act.CopyMode("MoveRight") },
		{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "o", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "q", action = act.CopyMode("Close") },
		{ key = "t", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		{ key = "v", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
		{ key = "y", mods = "CTRL", action = act.CopyMode("MoveUp") },
		{ key = "w", action = act.CopyMode("MoveForwardWord") },
		{
			key = "y",
			action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
		},
	},
	search_mode = {
		{ key = "Enter", action = act.CopyMode("Close") },
		{ key = "Escape", action = act.CopyMode("Close") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
		{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

return M
