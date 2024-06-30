local wezterm = require("wezterm")
local utils = require("utils")
local color = require("color")
local nerdfonts = wezterm.nerdfonts

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local nerd_icons = {
		nvim = nerdfonts.custom_vim,
		bash = nerdfonts.dev_terminal,
		zsh = nerdfonts.dev_terminal,
		ssh = nerdfonts.mdi_server,
		top = nerdfonts.mdi_monitor,
		docker = nerdfonts.dev_docker,
		ruby = nerdfonts.dev_ruby,
		node = nerdfonts.dev_nodejs_small,
		python = nerdfonts.dev_python,
	}

	local pane = tab.active_pane
	local process_name = utils.basename(pane.foreground_process_name)
	local index = tab.tab_index
	local icon = nerd_icons[process_name]
	local current_dir = string.gsub(pane.current_working_dir.path, ".*/(.*)", "%1")

	local title = { "" }
	if tab.active_pane.is_zoomed then
		table.insert(title, nerdfonts.fa_search_plus)
	end
	if index < 10 then
		table.insert(title, nerdfonts[string.format("md_numeric_%d_box_outline", index)])
	end
	if icon ~= nil then
		table.insert(title, icon)
	end
	table.insert(title, current_dir)
	table.insert(title, "")

	local background = color.bg3
	local foreground = color.fg

	local prefix = SOLID_LEFT_ARROW
	local suffix = SOLID_RIGHT_ARROW
	if tab.is_active then
		background = color.green
		foreground = color.black
	elseif hover then
		background = color.fg
		foreground = color.black
	end

	local edge_background = color.bg3
	local edge_foreground = background

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = prefix },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = table.concat(title, " ") },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = suffix },
	}
end)

local old_m, old_s, bat, bat_charging, bat_suffix = "", "", "", "", ""
wezterm.on("update-right-status", function(window)
	local update_flag = old_m == "" or old_m ~= wezterm.strftime("%M")
	if update_flag then
		old_m = wezterm.strftime("%M")

		local b = wezterm.battery_info()[1]
		bat = b.state_of_charge * 100
		if bat > 95 then
			bat_suffix = ""
		elseif bat > 90 then
			bat_suffix = "_90"
		elseif bat > 80 then
			bat_suffix = "_80"
		elseif bat > 70 then
			bat_suffix = "_70"
		elseif bat > 60 then
			bat_suffix = "_60"
		elseif bat > 50 then
			bat_suffix = "_50"
		elseif bat > 40 then
			bat_suffix = "_40"
		elseif bat > 30 then
			bat_suffix = "_30"
		elseif bat > 20 then
			bat_suffix = "_20"
		elseif bat > 10 then
			bat_suffix = "_10"
		end
		bat = string.format(" %.0f%% ", bat)
	end

	if old_s ~= wezterm.strftime("%S") then
		local b = wezterm.battery_info()[1]
		if b.state == "Charging" or b.state == "Unknown" then
			bat_charging = "_charging"
		else
			bat_charging = ""
		end
		old_s = wezterm.strftime("%S")
	end
	local icon = "  " .. nerdfonts["md_battery" .. bat_charging .. bat_suffix]
	window:set_right_status(wezterm.format({
		{ Text = icon .. bat },
	}))
end)

wezterm.on("toggle-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.7
		overrides.text_background_opacity = 0.7
	else
		overrides.window_background_opacity = nil
		overrides.text_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("spawn-tab-next-to-current-tab", function(window, pane)
	local tab = window:active_tab()
	local index = 0
	for _, t in ipairs(tab:window():tabs_with_info()) do
		if t.is_active then
			index = t.index
		end
	end
	window:perform_action(wezterm.action.SpawnTab("CurrentPaneDomain"), pane)
	window:perform_action(wezterm.action.MoveTab(index + 1), pane)
end)

wezterm.on("move-tab-next-to-current-tab", function(window, pane)
	local tab = window:active_tab()
	local index = 0
	for _, t in ipairs(tab:window():tabs_with_info()) do
		if t.is_active then
			index = t.index
		end
	end
	pane:move_to_new_tab()
	window:perform_action(wezterm.action.ActivateTab(-1), pane)
	window:perform_action(wezterm.action.MoveTab(index + 1), pane)
end)

wezterm.on("select-tab", function(window, pane)
	local tab = window:active_tab()
	local index = 0
	for _, t in ipairs(tab:window():tabs_with_info()) do
		if t.is_active then
			index = t.index
		end
	end
	window:perform_action(
		wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("HOME") .. "/.bin/_select-wezterm-tab", tostring(index) },
		}),
		pane
	)
end)

wezterm.on("open-bookmark", function(window, pane)
	local tab = window:active_tab()
	local index = 0
	for _, t in ipairs(tab:window():tabs_with_info()) do
		if t.is_active then
			index = t.index
		end
	end
	window:perform_action(
		wezterm.action.SpawnCommandInNewWindow({
			args = { os.getenv("HOME") .. "/.bin/bookmark", tostring(index) },
		}),
		pane
	)
end)
