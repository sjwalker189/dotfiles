-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:

local colors = {
	fg = "#D6D6D6",
	bg = "#121317",

	black = "#121317",
	red = "#cc6666",
	green = "#99cc99",
	yellow = "#f8fe7a",
	blue = "#81a2be",
	purple = "#8e6fbd",
	cyan = "#8abeb7",
	white = "#D6D6D6",

	black_bright = "#71727b",
	red_bright = "#D17575",
	green_bright = "#AED6AE",
	yellow_bright = "#F6FE5D",
	blue_bright = "#A1B9CE",
	purple_bright = "#A78FCC",
	cyan_bright = "#A3CCC7",
	white_bright = "silver",
}

-- Set background to same color as neovim
config.colors = {
	foreground = colors.fg,
	background = colors.bg,
	cursor_bg = colors.white,
	cursor_fg = "black",
	selection_bg = "#2A3E50",
	ansi = {
		colors.black,
		colors.red,
		colors.green,
		colors.yellow,
		colors.blue,
		colors.purple,
		colors.cyan,
		colors.white,
	},
	brights = {
		colors.black_bright,
		colors.red_bright,
		colors.green_bright,
		colors.yellow_bright,
		colors.blue_bright,
		colors.purple_bright,
		colors.cyan_bright,
		colors.white_bright,
	},
	tab_bar = {
		background = colors.bg,
		active_tab = {
			bg_color = "#1B1C22",
			fg_color = "#a6a6a6",
		},
		inactive_tab = {
			bg_color = colors.bg,
			fg_color = "#a6a6a6",
			italic = false,
		},
		inactive_tab_hover = {
			bg_color = colors.yellow,
			fg_color = colors.bg,
			italic = false,
		},
		new_tab = {
			bg_color = "#1B1C22", -- bright black
			fg_color = colors.fg,
		},
		new_tab_hover = {
			bg_color = colors.yellow,
			fg_color = colors.bg,
		},
	},
}

config.font_size = 11
config.font = wezterm.font_with_fallback({
	"Roboto Mono",
	"Sauce Code Pro Nerd Font",
	"nonicons",
})

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}
config.window_close_confirmation = "NeverPrompt"

config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true

config.freetype_load_target = "HorizontalLcd"

config.term = "wezterm"

-- Neovim zen mode integration
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)
config.set_environment_variables = {
	TERMINFO_DIRS = "/home/swalker/.terminfo",
}
config.term = "wezterm"

-- and finally, return the configuration to wezterm
return config
