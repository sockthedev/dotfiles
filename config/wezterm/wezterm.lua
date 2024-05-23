local wezterm = require("wezterm")

local act = wezterm.action

local config = {
	disable_default_key_bindings = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	adjust_window_size_when_changing_font_size = false,
	font = wezterm.font("Berkeley Mono", { weight = "Medium" }),
	font_size = 15,
	line_height = 1.3,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
		{ key = "0", mods = "SHIFT|CTRL", action = act.ResetFontSize },
		{ key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
		{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "F", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "F", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "L", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		{ key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		{ key = "Q", mods = "SHIFT|CTRL", action = act.QuitApplication },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
		{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "h", mods = "SHIFT|CTRL", action = act.HideApplication },
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },
		{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		{ key = "q", mods = "SHIFT|CTRL", action = act.QuitApplication },
		{ key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
	},
	force_reverse_video_cursor = true,
	-- tokyonight moon theme
	colors = {
		foreground = "#c0caf5",
		background = "#0F172A",
		cursor_bg = "#c0caf5",
		cursor_border = "#c0caf5",
		cursor_fg = "#1a1b26",
		selection_bg = "#283457",
		selection_fg = "#c0caf5",
		split = "#7aa2f7",
		compose_cursor = "#ff9e64",
		scrollbar_thumb = "#292e42",
		ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
		brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
		tab_bar = {
			inactive_tab_edge = "#16161e",
			background = "#1a1b26",
			active_tab = {
				fg_color = "#16161e",
				bg_color = "#7aa2f7",
			},
			inactive_tab = {
				fg_color = "#545c7e",
				bg_color = "#292e42",
			},
			inactive_tab_hover = {
				fg_color = "#7aa2f7",
				bg_color = "#292e42",
				-- intensity = "Bold"
			},
			new_tab_hover = {
				fg_color = "#7aa2f7",
				bg_color = "#1a1b26",
				intensity = "Bold",
			},
			new_tab = {
				fg_color = "#7aa2f7",
				bg_color = "#1a1b26",
			},
		},
	},
}

return config
