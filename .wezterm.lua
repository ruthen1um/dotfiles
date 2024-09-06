local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "kanagawa (Gogh)"
config.enable_tab_bar = false
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.audible_bell = "Disabled"

return config
