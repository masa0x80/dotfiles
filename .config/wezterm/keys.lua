local M = {}

local wezterm = require("wezterm")
local act = wezterm.action

M.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
M.keys = {
	{
		key = "Enter",
		mods = "SUPER",
		action = act.ToggleFullScreen,
	},

	{
		key = "c",
		mods = "LEADER",
		action = act.EmitEvent("spawn-tab-next-to-current-tab"),
	},

	{
		key = "p",
		mods = "LEADER|CTRL",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER|CTRL",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "P",
		mods = "LEADER",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "N",
		mods = "LEADER",
		action = act.MoveTabRelative(1),
	},

	{
		key = "s",
		mods = "LEADER|CTRL",
		action = act.ActivateLastTab,
	},

	{
		key = "\\",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "!",
		mods = "LEADER",
		action = act.EmitEvent("move-tab-next-to-current-tab"),
	},
	{
		key = "J",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "K",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "H",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "L",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},

	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "[",
		mods = "LEADER|CTRL",
		action = act.ActivateCopyMode,
	},
	{
		key = "f",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "f",
		mods = "LEADER|CTRL",
		action = act.ActivateCopyMode,
	},

	{
		key = "i",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Next"),
	},
	{
		key = "i",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Next"),
	},
	{
		key = "o",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Prev"),
	},
	{
		key = "o",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Prev"),
	},
	{
		key = "r",
		mods = "LEADER|CTRL",
		action = act.RotatePanes("Clockwise"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "h",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "l",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "k",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "j",
		mods = "LEADER|CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "q",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},

	{
		key = "b",
		mods = "LEADER",
		action = act.EmitEvent("select-tab"),
	},
	{
		key = "b",
		mods = "LEADER|CTRL",
		action = act.EmitEvent("select-tab"),
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
}

for i = 0, 7 do
	table.insert(M.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i),
	})
	table.insert(M.keys, {
		key = tostring(i),
		mods = "LEADER|CTRL",
		action = act.ActivateTab(i),
	})
end
table.insert(M.keys, {
	key = "8",
	mods = "LEADER",
	action = act.ActivateTab(-2),
})
table.insert(M.keys, {
	key = "8",
	mods = "LEADER|CTRL",
	action = act.ActivateTab(-2),
})
table.insert(M.keys, {
	key = "9",
	mods = "LEADER",
	action = act.ActivateTab(-1),
})
table.insert(M.keys, {
	key = "9",
	mods = "LEADER|CTRL",
	action = act.ActivateTab(-1),
})
table.insert(M.keys, {
	key = "-",
	mods = "LEADER|CTRL",
	action = act.ActivateTab(1),
})
for i = 0, 9 do
	table.insert(M.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.MoveTab(i),
	})
end

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

	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "H", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "L", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "K", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "J", action = act.AdjustPaneSize({ "Down", 1 }) },

		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
		{ key = "c", mods = "CTRL", action = "PopKeyTable" },
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
