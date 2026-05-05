local wezterm = require 'wezterm'

return {
  default_prog = { "pwsh.exe", "-NoLogo" },

  launch_menu = {
    { label = "PowerShell 7", args = { "pwsh.exe", "-NoLogo" } },
    { label = "Ubuntu (WSL)", args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" } },
  },

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  
  keys = {
    -- 실행 선택창 열기
    {
      key = "s",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ShowLauncher,
    },
    -- WSL 바로 새 탭으로 열기
    {
      key = "u",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SpawnCommandInNewTab {
        args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
      },
    },
    -- 수평 분할 : 위/아래
    {
      key = "h",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    -- 수직 분할 : 좌/우
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    -- pane 이동 (추가 추천)
    { key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Down" },
  },

  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = "CTRL",
      action = wezterm.action.IncreaseFontSize,
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = "CTRL",
      action = wezterm.action.DecreaseFontSize,
    },
  },

  font_size = 12.0,
}