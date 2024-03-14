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
		foreground = "#c8d3f5",
		background = "#222436",
		cursor_bg = "#c8d3f5",
		cursor_border = "#c8d3f5",
		cursor_fg = "#222436",
		selection_bg = "#2d3f76",
		selection_fg = "#c8d3f5",
		split = "#82aaff",
		compose_cursor = "#ff966c",
		scrollbar_thumb = "#2f334d",
		ansi = { "#1b1d2b", "#ff757f", "#c3e88d", "#ffc777", "#82aaff", "#c099ff", "#86e1fc", "#828bb8" },
		brights = { "#444a73", "#ff757f", "#c3e88d", "#ffc777", "#82aaff", "#c099ff", "#86e1fc", "#c8d3f5" },
		tab_bar = {
			background = "#222436",
			inactive_tab_edge = "#1e2030",
			active_tab = {
				bg_color = "#82aaff",
				fg_color = "#1e2030",
			},
			inactive_tab = {
				bg_color = "#2f334d",
				fg_color = "#545c7e",
			},
			inactive_tab_hover = {
				bg_color = "#2f334d",
				fg_color = "#82aaff",
				-- intensity = "Bold", -- This might need different handling as Lua config doesn't directly support this
			},
			new_tab = {
				bg_color = "#222436",
				fg_color = "#82aaff",
			},
			new_tab_hover = {
				bg_color = "#222436",
				fg_color = "#82aaff",
				intensity = "Bold",
			},
		},
	},
}

return config
