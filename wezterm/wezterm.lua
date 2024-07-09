local wezterm = require("wezterm")
wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. date },
	}))
end)

local config = {}

config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower"
config.max_fps = 60

-- Font Config
config.font = wezterm.font("CaskaydiaMono Nerd Font Mono", { weight = "DemiBold" })
config.font_size = 16

-- UI Config
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.exit_behavior = "Close"
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.native_macos_fullscreen_mode = false
config.term = "xterm-256color"
-- config.color_scheme = "tokyonight_moon"
config.color_scheme = "Tokyo Night Storm"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 60
config.bold_brightens_ansi_colors = true
config.bidi_enabled = true
config.bidi_direction = "AutoLeftToRight"
config.colors = {
	indexed = { [136] = "#ece100" },
}

-- Keyboard Settings
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
return config
