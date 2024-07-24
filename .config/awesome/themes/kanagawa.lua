local gears = require("gears")
local naughty = require("naughty")
package.path = package.path .. ";~/.local/share/nvim/lazy/kanagawa.nvim/lua/"
local status_ok, colorscheme = pcall(require, "kanagawa.colors")

if not status_ok then
    naughty.notification {
        urgency = "critical",
        message = ("couldn't load %"):format(colorscheme_name)
    }
end

local config_dir = gears.filesystem.get_configuration_dir()
local icons_dir = config_dir .. "icons/"

local theme = {}

local color = "lavender"

theme.font      = "JetBrains Mono NL 11"
theme.wallpaper = config_dir .. "wallpapers/catppuccin"
theme.icon_theme = nil

theme.bg_normal     = palette.base.hex
theme.bg_focus      = palette[color].hex
theme.bg_urgent     = palette.red.hex
theme.bg_minimize   = theme.bg_normal

theme.fg_normal     = palette.text.hex
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap         = 3
-- theme.border_width        = 1
-- theme.border_color_normal = theme.bg_normal
theme.border_color_normal = palette.text.hex
theme.border_color_active = theme.bg_focus

theme.titlebar_close_button_normal = icons_dir.."titlebar/close_normal.png"
theme.titlebar_close_button_focus  = icons_dir.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = icons_dir.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = icons_dir.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = icons_dir.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = icons_dir.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = icons_dir.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = icons_dir.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = icons_dir.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = icons_dir.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = icons_dir.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = icons_dir.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = icons_dir.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = icons_dir.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = icons_dir.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = icons_dir.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = icons_dir.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = icons_dir.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = icons_dir.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = icons_dir.."titlebar/maximized_focus_active.png"

theme.layout_fairh = icons_dir.."layouts/fairhw.png"
theme.layout_fairv = icons_dir.."layouts/fairvw.png"
theme.layout_floating  = icons_dir.."layouts/floatingw.png"
theme.layout_magnifier = icons_dir.."layouts/magnifierw.png"
theme.layout_max = icons_dir.."layouts/maxw.png"
theme.layout_fullscreen = icons_dir.."layouts/fullscreenw.png"
theme.layout_tilebottom = icons_dir.."layouts/tilebottomw.png"
theme.layout_tileleft   = icons_dir.."layouts/tileleftw.png"
theme.layout_tile = icons_dir.."layouts/tilew.png"
theme.layout_tiletop = icons_dir.."layouts/tiletopw.png"
theme.layout_spiral  = icons_dir.."layouts/spiralw.png"
theme.layout_dwindle = icons_dir.."layouts/dwindlew.png"
theme.layout_cornernw = icons_dir.."layouts/cornernww.png"
theme.layout_cornerne = icons_dir.."layouts/cornernew.png"
theme.layout_cornersw = icons_dir.."layouts/cornersww.png"
theme.layout_cornerse = icons_dir.."layouts/cornersew.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
