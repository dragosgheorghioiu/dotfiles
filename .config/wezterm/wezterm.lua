local wezterm = require("wezterm")
local moon = {}

local moon_palette = {
  	base = "#1c1625",
    overlay = "#1c1625",
    muted = '#6e6a86',
    text = '#e0def4',
    love = '#eb6f92',
    gold = '#f6c177',
    -- rose = '#ea9a97',
    pine = '#3e8fb0',
    foam = '#9ccfd8',
    iris = '#c4a7e7',
    -- highlight_high = '#56526e',
}

local moon_active_tab = {
    bg_color = moon_palette.overlay,
    fg_color = moon_palette.text,
}

local moon_inactive_tab = {
    bg_color = moon_palette.base,
    fg_color = moon_palette.muted,
}

function moon.colors()
    return {
        foreground = moon_palette.text,
        background = moon_palette.base,
        cursor_bg = '#59546d',
        cursor_border = '#59546d',
        cursor_fg = moon_palette.text,
        selection_bg = moon_palette.overlay,
        selection_fg = moon_palette.text,

        ansi = {
            moon_palette.overlay,
            moon_palette.love,
            moon_palette.pine,
            moon_palette.gold,
            moon_palette.foam,
            moon_palette.iris,
            '#ebbcba', -- replacement for rose,
            moon_palette.text,
        },

        brights = {
            '#817c9c', -- replacement for muted,
            moon_palette.love,
            moon_palette.pine,
            moon_palette.gold,
            moon_palette.foam,
            moon_palette.iris,
            '#ebbcba', -- replacement for rose,
            moon_palette.text,
        },

        tab_bar = {
            background = moon_palette.base,
            active_tab = moon_active_tab,
            inactive_tab = moon_inactive_tab,
            inactive_tab_hover = moon_active_tab,
            new_tab = moon_inactive_tab,
            new_tab_hover = moon_active_tab,
            inactive_tab_edge = moon_palette.muted, -- (Fancy tab bar only)
        },
    }
end

function moon.window_frame() -- (Fancy tab bar only)
    return {
        active_titlebar_bg = moon_palette.base,
        inactive_titlebar_bg = moon_palette.base,
    }
end


local M = {
	colors = moon.colors(),
	window_frame = moon.window_frame(),
	-- window_decorations = "NONE",
	font = wezterm.font("JetBrains Mono"),
	font_size = 20.0,
	show_tab_index_in_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	max_fps = 120,
}

-- windows additional keybindings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- adding tmux like keybindings
	local windows_additional_config = {
		leader = { key = "a", mods = "CTRL" },
		keys = {
			{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
			{
				key = "-",
				mods = "LEADER",
				action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
			},
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
			{
				key = "s",
				mods = "LEADER",
				action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
			},
			{
				key = '"',
				mods = "LEADER|SHIFT",
				action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
			},
			{
				key = "v",
				mods = "LEADER",
				action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
			},
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

	-- set powershell as default
	windows_additional_config.default_prog = { "pwsh.exe", "-NoLogo" }

	for key, value in pairs(windows_additional_config) do
		M[key] = value
	end
end

return M
