local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local config = wezterm.config_builder()

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2500 }
config.disable_default_key_bindings = false
config.keys = {
	-- Disable Ctrl-Shift-L (default action: ShowDebugOverlay)
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- create window
	{
		mods = "CTRL | SHIFT",
		key = "n",
		action = wezterm.action.SpawnWindow,
	},
	-- toggle window level
	{
		mods = "CTRL | SHIFT",
		key = "o",
		action = wezterm.action_callback(function(window, pane)
			local level = window:get_window_level()
			if level == "Normal" then
				window:set_window_level("AlwaysOnTop")
			else
				window:set_window_level("Normal")
			end
		end),
	},
	-- create tabs
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- close tab
	{
		mods = "LEADER",
		key = "w",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
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
		key = "'",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "\\",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- focus pane
	{
		mods = "LEADER",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- quite / close pane
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
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
		mods = "LEADER",
		key = "Enter",
		action = wezterm.action.ActivateCopyMode,
	},
	-- copy and paste
	-- NOTE: in copy mode you don't need the modifiers
	{
		mods = "LEADER",
		key = "y",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- Font size
	{
		mods = "LEADER|SHIFT",
		key = "-",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		mods = "LEADER|SHIFT",
		key = "+",
		action = wezterm.action.IncreaseFontSize,
	},
}
-- config.font = wezterm.font("3270SemiCondensed Nerd Font Mono")
-- config.font = wezterm.font("Operator Mono SSm", { weight = "Book" })
-- config.font = wezterm.font("MonoLisa")
-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
-- config.font = wezterm.font("IntelOne Mono", { weight = "Regular" })
-- config.font = wezterm.font("Andale Mono", { weight = "Regular" })
config.font = wezterm.font("Berkeley Mono", { weight = "Regular" })
config.font_size = 13
config.line_height = 1.2
config.scrollback_lines = 10000
config.max_fps = 120
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
config.send_composed_key_when_left_alt_is_pressed = false
config.tab_max_width = 80
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 1,
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"
config.adjust_window_size_when_changing_font_size = false

-- local background = "#191919"
local background = "#000"
local foreground = "#DCD7BA"
local foreground_dim = "#333"
local highlight = "#aaa"

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
	background = background,
	foreground = foreground,
	cursor_bg = "#c8c093",
	cursor_fg = background,
	cursor_border = "#c8c093",
	selection_bg = "#363646",
	quick_select_label_bg = { Color = "#60b5de" },
	quick_select_label_fg = { Color = "#ffffff" },
	quick_select_match_bg = { Color = "#c07d9e" },
	quick_select_match_fg = { Color = "#ffffff" },
	scrollbar_thumb = "#393836",
	split = foreground_dim,
	tab_bar = {
		background = background,
		inactive_tab_edge = "rgba(28, 28, 28, 0.9)",
		active_tab = {
			bg_color = highlight,
			fg_color = background,
		},
		inactive_tab = {
			bg_color = background,
			fg_color = foreground_dim,
		},
		inactive_tab_hover = {
			bg_color = background,
			fg_color = foreground_dim,
		},
	},
	indexed = {
		[16] = "#b6927b",
		[17] = "#ff5d62",
	},
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = os.getenv("HOME")
	return current_dir.file_path == HOME_DIR and "~" or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab)
	local cwd = wezterm.format({
		{ Text = get_current_working_dir(tab) },
	})
	return {
		{ Text = string.format(" %s ", cwd) },
	}
end)

-- Adds pane navigation and resizing keybindings
-- CTRL + h/j/k/l to navigate panes
-- ALT + h/j/k/l to resize panes
smart_splits.apply_to_config(config)

return config
