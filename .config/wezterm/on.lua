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
	local current_dir = string.gsub(pane.current_working_dir, "(.*[/\\])(.*[/\\].*)", "%2")

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

	local background = color.VISUAL_GREY
	local foreground = color.WHITE

	if tab.is_active then
		background = color.GREEN
		foreground = color.BLACK
	elseif hover then
		background = color.WHITE
		foreground = color.BLACK
	end

	local edge_background = color.NONE
	local edge_foreground = background

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = table.concat(title, " ") },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

local old_m, date, time, bat = "", "", "", ""
wezterm.on("update-right-status", function(window)
	local update_flag = old_m == "" or old_m ~= wezterm.strftime("%M")
	if update_flag then
		old_m = wezterm.strftime("%M")
		date = nerdfonts.cod_calendar .. " " .. wezterm.strftime("%Y-%m-%d %a") .. "  "

		local clock_icon = ""
		local h = tonumber(wezterm.strftime("%H")) % 12
		if h == 1 then
			clock_icon = nerdfonts.md_clock_time_one_outline
		elseif h == 2 then
			clock_icon = nerdfonts.md_clock_time_two_outline
		elseif h == 3 then
			clock_icon = nerdfonts.md_clock_time_three_outline
		elseif h == 4 then
			clock_icon = nerdfonts.md_clock_time_four_outline
		elseif h == 5 then
			clock_icon = nerdfonts.md_clock_time_five_outline
		elseif h == 6 then
			clock_icon = nerdfonts.md_clock_time_six_outline
		elseif h == 7 then
			clock_icon = nerdfonts.md_clock_time_seven_outline
		elseif h == 8 then
			clock_icon = nerdfonts.md_clock_time_eight_outline
		elseif h == 9 then
			clock_icon = nerdfonts.md_clock_time_nine_outline
		elseif h == 10 then
			clock_icon = nerdfonts.md_clock_time_ten_outline
		elseif h == 11 then
			clock_icon = nerdfonts.md_clock_time_eleven_outline
		else
			clock_icon = nerdfonts.md_clock_time_twelve_outline
		end
		time = clock_icon .. " " .. wezterm.strftime("%H:%M:")

		for _, b in ipairs(wezterm.battery_info()) do
			local icon = ""
			bat = b.state_of_charge * 100
			if bat > 80 then
				icon = nerdfonts.fa_battery_full
			elseif bat > 75 then
				icon = nerdfonts.fa_battery_three_quarters
			elseif bat > 50 then
				icon = nerdfonts.fa_battery_half
			elseif bat > 25 then
				icon = nerdfonts.fa_battery_quarter
			else
				icon = nerdfonts.fa_battery_empty
			end
			bat = string.format("  " .. icon .. "  %.0f%% ", bat)
		end
	end

	window:set_right_status(wezterm.format({
		{ Text = date .. time .. wezterm.strftime("%S") .. bat },
	}))
end)

wezterm.on("toggle-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.6
		overrides.text_background_opacity = 0.6
	else
		overrides.window_background_opacity = nil
		overrides.text_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text()
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()
	window:perform_action(
		wezterm.action.SpawnCommandInNewTab({
			args = { "nvim", name },
		}),
		pane
	)
	wezterm.sleep_ms(1000)
	os.remove(name)
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
			args = { os.getenv("HOME") .. "/.bin/select-wezterm-tab", tostring(index) },
		}),
		pane
	)
end)
