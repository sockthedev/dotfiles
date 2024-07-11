local wezterm = require("wezterm")

-- TODO: How to switch from Tmux to Wezterm:
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm

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
		{ key = "_", mods = "SHIFT|CTRL", action = act.DecreaseFontSize },
		{ key = "0", mods = "SHIFT|CTRL", action = act.ResetFontSize },
		{ key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
		{ key = "C", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "F", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "F", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "P", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
		{ key = "Q", mods = "SHIFT|CTRL", action = act.QuitApplication },
		{ key = "q", mods = "SHIFT|CTRL", action = act.QuitApplication },
		{ key = "R", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },
		{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		{ key = "PageUp", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
		{ key = "PageDown", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
	},
	force_reverse_video_cursor = true,
	colors = {
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
		indexed = {
			[16] = "#b6927b",
			[17] = "#ff5d62",
		},
	},
}

return config
