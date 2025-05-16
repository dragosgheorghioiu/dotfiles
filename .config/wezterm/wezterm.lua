local wezterm = require("wezterm")

function monokai_colors()
  return {
    foreground = "#FCFCFA",
    background = "#282A3A",
    cursor_bg = '#FCFCFA',
    cursor_border = '#FCFCFA',
    selection_bg = '#333842',

    ansi = {
      "#403E41",
      "#FF6188",
      "#A9DC76",
      "#FFD866",
      "#FC9867",
      "#AB9DF2",
      "#78DCE8",
      "#FCFCFA",
    },

    brights = {
      "#727072",
      "#FF6188",
      "#A9DC76",
      "#FFD866",
      "#FC9867",
      "#AB9DF2",
      "#78DCE8",
      "#FCFCFA",
    },
  }
end

local M = {
  colors = monokai_colors(),
  -- window_decorations = "NONE",
  font = wezterm.font("JetBrains Mono NL"),
  font_size = 10.0,
  show_tab_index_in_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  max_fps = 120,
  default_cursor_style = "SteadyBlock",
  leader = { key = "a", mods = "CTRL" },
  keys = {
    { key = "a", mods = "LEADER|CTRL",  action = wezterm.action({ SendString = "\x01" }) },
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
    { key = "o", mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
    { key = "c", mods = "LEADER",       action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
    { key = "h", mods = "CTRL",         action = wezterm.action({ ActivatePaneDirection = "Left" }) },
    { key = "j", mods = "CTRL",         action = wezterm.action({ ActivatePaneDirection = "Down" }) },
    { key = "k", mods = "CTRL",         action = wezterm.action({ ActivatePaneDirection = "Up" }) },
    { key = "l", mods = "CTRL",         action = wezterm.action({ ActivatePaneDirection = "Right" }) },
    { key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
    { key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
    { key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
    { key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
    { key = "n", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER",       action = wezterm.action.ActivateTabRelative(-1) },
    { key = "h", mods = "CTRL|ALT",     action = wezterm.action.ActivateTabRelative(-1) },
    { key = "l", mods = "CTRL|ALT",     action = wezterm.action.ActivateTabRelative(1) },
    { key = "1", mods = "LEADER",       action = wezterm.action({ ActivateTab = 0 }) },
    { key = "2", mods = "LEADER",       action = wezterm.action({ ActivateTab = 1 }) },
    { key = "3", mods = "LEADER",       action = wezterm.action({ ActivateTab = 2 }) },
    { key = "4", mods = "LEADER",       action = wezterm.action({ ActivateTab = 3 }) },
    { key = "5", mods = "LEADER",       action = wezterm.action({ ActivateTab = 4 }) },
    { key = "6", mods = "LEADER",       action = wezterm.action({ ActivateTab = 5 }) },
    { key = "7", mods = "LEADER",       action = wezterm.action({ ActivateTab = 6 }) },
    { key = "8", mods = "LEADER",       action = wezterm.action({ ActivateTab = 7 }) },
    { key = "9", mods = "LEADER",       action = wezterm.action({ ActivateTab = 8 }) },
    { key = "d", mods = "LEADER",       action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
    { key = "x", mods = "LEADER",       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
  },
}

return M
