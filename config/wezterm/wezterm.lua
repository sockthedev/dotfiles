local wezterm = require("wezterm")

local config = wezterm.config_builder()

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 400
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2500 }

config.disable_default_key_bindings = true
config.keys = {
	-- create tabs
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- navigate tabs
	{
		mods = "LEADER",
		key = "[",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "]",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		mods = "LEADER",
		key = "1",
		action = wezterm.action.ActivateTab(0),
	},
	{
		mods = "LEADER",
		key = "2",
		action = wezterm.action.ActivateTab(1),
	},
	{
		mods = "LEADER",
		key = "3",
		action = wezterm.action.ActivateTab(2),
	},
	{
		mods = "LEADER",
		key = "4",
		action = wezterm.action.ActivateTab(3),
	},
	{
		mods = "LEADER",
		key = "5",
		action = wezterm.action.ActivateTab(4),
	},
	{
		mods = "LEADER",
		key = "6",
		action = wezterm.action.ActivateTab(5),
	},
	{
		mods = "LEADER",
		key = "7",
		action = wezterm.action.ActivateTab(6),
	},
	{
		mods = "LEADER",
		key = "8",
		action = wezterm.action.ActivateTab(7),
	},
	{
		mods = "LEADER",
		key = "9",
		action = wezterm.action.ActivateTab(8),
	},
	-- splitting panes
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- focus pane
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	-- activate copy mode or vim mode
	{
		mods = "CTRL | SHIFT",
		key = "Enter",
		action = wezterm.action.ActivateCopyMode,
	},
	-- copy and paste
	-- NOTE: in copy mode you don't need the modifiers
	{
		mods = "CTRL | SHIFT",
		key = "y",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		mods = "CTRL | SHIFT",
		key = "p",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- Font size
	{
		mods = "CTRL | SHIFT",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		mods = "CTRL | SHIFT",
		key = "+",
		action = wezterm.action.IncreaseFontSize,
	},
}

config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.font = wezterm.font("Berkeley Mono", { weight = "Medium" })
config.font_size = 15
config.line_height = 1.3

config.colors = {
	ansi = {
		"#0d0c0c",
		"#c4746e",
		"#9a9a7b",
		"#c4b28a",
		"#8ba4b0",
		"#a292a3",
		"#8ea4a2",
		"#C8C093",
	},
	brights = {
		"#a6a69c",
		"#E46876",
		"#87a987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#c5c9c5",
	},
	background = "#1F1F28",
	foreground = "#DCD7BA",
	cursor_bg = "#c8c093",
	cursor_fg = "#1f1f28",
	cursor_border = "#c8c093",
	selection_bg = "#658594",
	selection_fg = "#c8c093",
	scrollbar_thumb = "#393836",
	split = "#8992a7",
	tab_bar = {
		background = "#1f1f28",
		active_tab = {
			bg_color = "#1f1f28",
			fg_color = "#DCD7BA",
			intensity = "Normal",
			underline = "Single",
		},
		inactive_tab = {
			bg_color = "#1f1f28",
			fg_color = "#DCD8BA",
		},
		inactive_tab_hover = {
			bg_color = "#1f1f28",
			fg_color = "#DCD7BA",
			italic = false,
		},
		new_tab = {
			bg_color = "#1f1f28",
			fg_color = "#DCD7BA",
		},
		new_tab_hover = {
			bg_color = "#1f1f28",
			fg_color = "#DCD7BA",
			italic = false,
		},
	},
	indexed = {
		[16] = "#b6927b",
		[17] = "#ff5d62",
	},
}

smart_splits.apply_to_config(config, {
	-- the default config is here, if you'd like to use the default keys,
	-- you can omit this configuration table parameter and just use
	-- smart_splits.apply_to_config(config)

	-- directional keys to use in order of: left, down, up, right
	direction_keys = { "h", "j", "k", "l" },
	-- modifier keys to combine with direction_keys
	modifiers = {
		move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
		resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
	},
})

return config
