local wezterm = require("wezterm")
local main = {}

local main_palette = {
	base = "#1c1625",
	overlay = "#1c1625",
	muted = "#777777",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_high = "#524f67",
}

local main_active_tab = {
	bg_color = main_palette.overlay,
	fg_color = main_palette.text,
}

local main_inactive_tab = {
	bg_color = main_palette.base,
	fg_color = main_palette.text,
}

function main.colors()
	return {
		foreground = main_palette.text,
		background = main_palette.base,
		cursor_bg = main_palette.highlight_high,
		cursor_border = main_palette.highlight_high,
		cursor_fg = main_palette.text,
		selection_bg = "#2a283e",
		selection_fg = main_palette.text,

		ansi = {
			main_palette.overlay,
			main_palette.love,
			main_palette.pine,
			main_palette.gold,
			main_palette.foam,
			main_palette.iris,
			main_palette.rose,
			main_palette.text,
		},

		brights = {
			main_palette.muted,
			main_palette.love,
			main_palette.pine,
			main_palette.gold,
			main_palette.foam,
			main_palette.iris,
			main_palette.rose,
			main_palette.text,
		},

		tab_bar = {
			background = main_palette.base,
			active_tab = main_active_tab,
			inactive_tab = main_inactive_tab,
			inactive_tab_hover = main_active_tab,
			new_tab = main_inactive_tab,
			new_tab_hover = main_active_tab,
			inactive_tab_edge = main_palette.muted, -- (Fancy tab bar only)
		},
	}
end

function main.window_frame() -- (Fancy tab bar only)
	return {
		active_titlebar_bg = main_palette.base,
		inactive_titlebar_bg = main_palette.base,
	}
end

return {
	default_prog = { "pwsh.exe", "-NoLogo" },
	colors = main.colors(),
	window_frame = main.window_frame(),
	-- window_decorations = "NONE",
	font = wezterm.font("JetBrains Mono"),
	font_size = 14.0,
	show_tab_index_in_tab_bar = true,
	leader = { key = "a", mods = "CTRL" },
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
		{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "%",
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "o", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "h", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "CTRL", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
		{ key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	},
}
