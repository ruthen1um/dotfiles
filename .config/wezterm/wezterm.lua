local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- tab bar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- misc
config.skip_close_confirmation_for_processes_named = { "zsh" }

config.audible_bell = "Disabled"

-- appearance
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.color_scheme = "kanagawa (Gogh)"

config.disable_default_key_bindings = true

config.colors = require("colors")
config.keys = require("keys")

return config
