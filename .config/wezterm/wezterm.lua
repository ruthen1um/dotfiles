local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- appearance
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.color_scheme = "kanagawa (Gogh)"

-- tab bar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- misc
config.skip_close_confirmation_for_processes_named = { "zsh" }

config.audible_bell = "Disabled"

return config
