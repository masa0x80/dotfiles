local wezterm = require("wezterm")
local utils = require("utils")
local keys = require("keys")
local mouse_bindings = require("mouse_bindings")
require("on")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("UDEV Gothic NF")
config.color_scheme = "OneDark (base16)"
config.window_decorations = "RESIZE"
config.font_size = 16.0
config.adjust_window_size_when_changing_font_size = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 64
config.scrollback_lines = 10000
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.switch_to_last_active_tab_when_closing_tab = true
config.disable_default_key_bindings = true
config.front_end = "WebGpu"
config.status_update_interval = 250
config.window_padding = {
	left = 10,
	right = 5,
	top = 0,
	bottom = 0,
}
config.set_environment_variables = {
	PATH = os.getenv("HOME") .. "/.asdf/shims:" .. os.getenv("PATH"),
}
-- config.debug_key_events = true

utils.merge_tables(config, keys)
utils.merge_tables(config, mouse_bindings)

return config