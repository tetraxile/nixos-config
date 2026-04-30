local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font = wezterm.font_with_fallback {
  "monospace",
  {
    family = "Klee One",
    scale = 1.2,
  },
  {
    family = "nasin-nanpa",
    stretch = "UltraExpanded",
  }
}

config.harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga = 0' }


return config
