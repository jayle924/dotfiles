local wezterm = require 'wezterm'
 
return {
  -- 기본 설정
  default_prog = { "pwsh.exe", "-NoLogo" },
  use_ime = true,
  ime_preedit_rendering = "Builtin",

  -- 탭 설정
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,

  -- 폰트 설정 (글자 크기, 글꼴 패밀리)
  font_size = 12.0,
  font = wezterm.font_with_fallback {
    "D2CodingLigature Nerd Font Mono",
    "D2Coding ligature",                 
  },
  
  launch_menu = {
    { label = "PowerShell 7", args = { "pwsh.exe", "-NoLogo" } },
    { label = "Ubuntu (WSL)", args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" } },
  },
 
  keys = {
    -- ──────────────────────────────────────────
    -- 실행 선택창 열기
    -- ──────────────────────────────────────────
    {
      key = "s",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ShowLauncher,
    },
 
    -- ──────────────────────────────────────────
    -- WSL 새 탭
    -- ──────────────────────────────────────────
    {
      key = "u",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SpawnCommandInNewTab {
        args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" },
      },
    },
 
    -- ──────────────────────────────────────────
    -- 분할
    -- ──────────────────────────────────────────
    -- 수평 분할 (좌/우)
    {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    -- 수직 분할 (상/하)
    {
      key = '"',
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
 
    -- ──────────────────────────────────────────
    -- [추가] 화면 병합 (현재 패널 닫기)
    --   CTRL+SHIFT+X : 현재 포커스 패널 닫아서 나머지 패널로 합치기
    --   CTRL+SHIFT+Z : 현재 패널 줌 토글 (전체화면 ↔ 원래 크기)
    -- ──────────────────────────────────────────
    {
      key = "x",
      mods = "CTRL|SHIFT",
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
      key = "z",
      mods = "CTRL|SHIFT",
      action = wezterm.action.TogglePaneZoomState,
    },
 
    -- ──────────────────────────────────────────
    -- 패널 이동
    -- ──────────────────────────────────────────
    { key = "h", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "l", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", mods = "CTRL|ALT", action = wezterm.action.ActivatePaneDirection "Down" },
 
    -- ──────────────────────────────────────────
    -- [추가] 복사 / 붙여넣기
    --   CTRL+C : 선택 영역이 있으면 복사, 없으면 기존 인터럽트(^C) 전달
    --   CTRL+V : 클립보드 붙여넣기
    --   CTRL+SHIFT+C/V : 항상 클립보드 복사/붙여넣기 (안전한 대안)
    -- ──────────────────────────────────────────
    {
      key = "c",
      mods = "CTRL",
      -- 선택 중일 때만 복사, 아니면 ^C 시그널 그대로 전달
      action = wezterm.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ""
        if has_selection then
          window:perform_action(wezterm.action.CopyTo "Clipboard", pane)
        else
          window:perform_action(wezterm.action.SendKey { key = "c", mods = "CTRL" }, pane)
        end
      end),
    },
    {
      key = "v",
      mods = "CTRL",
      action = wezterm.action.PasteFrom "Clipboard",
    },
    -- 명시적 복사/붙여넣기 (선택 여부 무관하게 항상 동작)
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action.CopyTo "Clipboard",
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action.PasteFrom "Clipboard",
    },
  },
 
  mouse_bindings = {
    -- CTRL + 마우스 휠로 폰트 크기 조절
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
    -- [추가] 우클릭으로 붙여넣기
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action.PasteFrom "Clipboard",
    },
    -- [추가] 드래그 선택 후 자동으로 클립보드에 복사
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor "Clipboard",
    },
  },
}