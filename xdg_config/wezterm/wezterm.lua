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

	-- TODO: Gray scale from 0 - 9
	-- TOOD: Brights

	black = "#121317", -- black
	red = "#cc6666", -- red
	green = "#99cc99", -- green
	yellow = "#f8fe7a", -- yellow
	blue = "#81a2be", -- blue
	purple = "#8e6fbd", -- purple
	cyan = "#8abeb7", -- cyan
	white = "#D6D6D6", -- white
}

-- Set background to same color as neovim
config.colors = {
	foreground = colors.fg,
	background = colors.bg,
	cursor_bg = colors.white,
	cursor_fg = "black",
	selection_bg = "#2A3E50",
	ansi = {
		"#121317", -- black
		"#cc6666", -- red
		"#99cc99", -- green
		"#f8fe7a", -- yellow
		"#81a2be", -- blue
		"#8e6fbd", -- purple
		"#8abeb7", -- cyan
		"#D6D6D6", -- white
	},
	brights = {
		"#1B1C22", -- black
		"#D17575", -- red
		"#AED6AE", -- green
		"#F6FE5D", -- yellow
		"#A1B9CE", -- blue
		"#A78FCC", -- purple
		"#A3CCC7", -- cyan
		"#FFFFFF", -- white
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
	"MonoLisa",
	-- "Berkeley Mono",
	-- "nonicons",
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

-- and finally, return the configuration to wezterm
return config
