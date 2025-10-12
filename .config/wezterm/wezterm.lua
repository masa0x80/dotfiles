local wezterm = require("wezterm")
local utils = require("utils")
local keys = require("keys")
local mouse_bindings = require("mouse_bindings")
require("on")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({ "Pending Mono HWNF", "Apple Color Emoji" })
-- config.harfbuzz_features = { "calt=1", "cv01=2", "cv02=1", "cv31=1", "liga=0" }
config.text_background_opacity = 0.85
config.font_size = 13.0
config.adjust_window_size_when_changing_font_size = true
-- config.cell_width = 0.9
-- config.line_height = 1.0
config.use_cap_height_to_scale_fallback_fonts = true

config.color_scheme = "Everforest Dark (Gogh)"
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 64
config.scrollback_lines = 10000
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.switch_to_last_active_tab_when_closing_tab = true
config.disable_default_key_bindings = true
config.front_end = "WebGpu"
config.status_update_interval = 1000
config.initial_rows = 64
config.initial_cols = 256
config.window_padding = {
	left = 10,
	right = 5,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}
config.default_cursor_style = "BlinkingBlock"
config.term = "wezterm"

utils.merge_tables(config, keys)
utils.merge_tables(config, mouse_bindings)

return config
