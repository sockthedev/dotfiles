local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local config = wezterm.config_builder()

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2500 }
config.disable_default_key_bindings = true
config.keys = {
	-- create tabs
	{
		mods = "CTRL | SHIFT",
		key = "t",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- close tab
	{
		mods = "CTRL | SHIFT",
		key = "w",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	-- navigate tabs
	{
		mods = "CTRL | SHIFT",
		key = "[",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "CTRL | SHIFT",
		key = "]",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "CTRL | SHIFT",
		key = "1",
		action = wezterm.action.ActivateTab(0),
	},
	{
		mods = "CTRL | SHIFT",
		key = "2",
		action = wezterm.action.ActivateTab(1),
	},
	{
		mods = "CTRL | SHIFT",
		key = "3",
		action = wezterm.action.ActivateTab(2),
	},
	{
		mods = "CTRL | SHIFT",
		key = "4",
		action = wezterm.action.ActivateTab(3),
	},
	{
		mods = "CTRL | SHIFT",
		key = "5",
		action = wezterm.action.ActivateTab(4),
	},
	{
		mods = "CTRL | SHIFT",
		key = "6",
		action = wezterm.action.ActivateTab(5),
	},
	{
		mods = "CTRL | SHIFT",
		key = "7",
		action = wezterm.action.ActivateTab(6),
	},
	{
		mods = "CTRL | SHIFT",
		key = "8",
		action = wezterm.action.ActivateTab(7),
	},
	{
		mods = "CTRL | SHIFT",
		key = "9",
		action = wezterm.action.ActivateTab(8),
	},
	-- splitting panes
	{
		mods = "CTRL | SHIFT",
		key = '"',
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL | SHIFT",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- focus pane
	{
		mods = "CTRL | SHIFT",
		key = "z",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- close pane
	{
		mods = "CTRL | SHIFT",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- rotate panes
	{
		mods = "CTRL | SHIFT",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "CTRL | SHIFT",
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
config.font = wezterm.font("Berkeley Mono", { weight = "Medium" })
config.font_size = 15
config.line_height = 1.3
config.scrollback_lines = 10000
config.max_fps = 120
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 400
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.switch_to_last_active_tab_when_closing_tab = true
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
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
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
	quick_select_label_bg = { Color = "#60b5de" },
	quick_select_label_fg = { Color = "#ffffff" },
	quick_select_match_bg = { Color = "#c07d9e" },
	quick_select_match_fg = { Color = "#ffffff" },
	scrollbar_thumb = "#393836",
	split = "#8992a7",
	tab_bar = {
		background = "#1f1f28",
		inactive_tab_edge = "rgba(28, 28, 28, 0.9)",
		active_tab = {
			bg_color = "#1f1f28",
			fg_color = "#c0c0c0",
		},
		inactive_tab = {
			bg_color = "#1f1f28",
			fg_color = "#808080",
		},
		inactive_tab_hover = {
			bg_color = "#1f1f28",
			fg_color = "#808080",
		},
	},
	indexed = {
		[16] = "#b6927b",
		[17] = "#ff5d62",
	},
}

local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["mysql"] = "󱤢",
	["psql"] = "󱤢",
	["ssh"] = wezterm.nerdfonts.fa_exchange,
	["ssh-add"] = wezterm.nerdfonts.fa_exchange,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["go"] = wezterm.nerdfonts.seti_go,
	["python"] = "",
	["python2"] = "",
	["python3"] = "",
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
	local HOME_DIR = os.getenv("HOME")
	return current_dir.file_path == HOME_DIR and "~" or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return nil
	end
	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	return process_icons[process_name] or string.format("[%s]", process_name)
end

wezterm.on("format-tab-title", function(tab)
	local cwd = wezterm.format({
		{ Text = get_current_working_dir(tab) },
	})
	local process = get_process(tab)
	if tab.tab_index == 0 then
		return {
			{ Text = process and string.format("  %s  %s (1) ", process, cwd) or " [?] " },
		}
	end
	return {
		{ Text = process and string.format("|  %s  %s (%s) ", process, cwd, tab.tab_index + 1) or " [?] " },
	}
end)

-- Adds pane navigation and resizing keybindings
-- CTRL + h/j/k/l to navigate panes
-- ALT + h/j/k/l to resize panes
smart_splits.apply_to_config(config)

return config
