-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")

-- Keys help
local hotkeys_popup = require("awful.hotkeys_popup")

local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- Apply theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/catppuccin.lua")

local terminal = "kitty"
local screenshot_tool = "flameshot gui"
local modkey = "Mod4"
-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.fair,
        awful.layout.suit.tile,
        awful.layout.suit.spiral,
        awful.layout.suit.floating,
    })
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                resize                = true,
                image                 = beautiful.wallpaper,
                widget                = wibox.widget.imagebox,
                horizontal_fit_policy = "fit",
                vertical_fit_policy   = "fit",
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock("%d.%m.%y %H:%M")

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, awful.button.names.SCROLL_UP, function() awful.layout.inc(1) end),
            awful.button({ }, awful.button.names.SCROLL_DOWN, function() awful.layout.inc(-1) end),
        }
    }

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, awful.button.names.LEFT, function(t) t:view_only() end),
            awful.button({ modkey }, awful.button.names.LEFT, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, awful.button.names.RIGHT, awful.tag.viewtoggle),
            awful.button({ modkey }, awful.button.names.RIGHT, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, awful.button.names.SCROLL_DOWN, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, awful.button.names.SCROLL_UP, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        style = {
            shape = gears.shape.rounded_bar,
        },
        layout = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape        = gears.shape.circle,
                    widget       = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal
        },
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, awful.button.names.LEFT, function(c)
                c.minimized = not c.minimized
            end),
            awful.button({ }, awful.button.names.SCROLL_DOWN, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, awful.button.names.SCROLL_UP, function() awful.client.focus.byidx(1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        border_width = 1,
        border_color = beautiful.border_color_active,
        widget = {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            s.mytaglist,
            {
                layout = wibox.layout.fixed.horizontal,
                s.mytasklist,
            },
            {
                layout = wibox.layout.fixed.horizontal,
                s.mypromptbox,
                mykeyboardlayout,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            }
        }
    }
end)

-- }}}

-- {{{ Key bindings

-- Awesome related keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "/", hotkeys_popup.show_help,
              { description = "show help", group = "awesome" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "Left", awful.tag.viewprev,
              { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext,
              { description = "view next", group = "tag" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "Left", function() awful.layout.inc(-1) end,
              { description = "select previous", group = "layout" }),
    awful.key({ modkey, "Control" }, "Right", function() awful.layout.inc(1) end,
              { description = "select next", group = "layout" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "h", function() awful.client.focus.bydirection("left", client.focus) end,
              { description = "switch to the client on the left", group = "focus" }),
    awful.key({ modkey }, "j", function() awful.client.focus.bydirection("down", client.focus) end,
              { description = "switch to the client below", group = "focus" }),
    awful.key({ modkey }, "k", function() awful.client.focus.bydirection("up", client.focus) end,
              { description = "switch to the client above", group = "focus" }),
    awful.key({ modkey }, "l", function() awful.client.focus.bydirection("right", client.focus) end,
              { description = "switch to the client on the right", group = "focus" }),

    awful.key({ modkey, "Control" }, "h", function() awful.client.swap.bydirection("left", client.focus) end,
              { description = "swap the focused client with the client on the left", group = "focus" }),
    awful.key({ modkey, "Control" }, "j", function() awful.client.swap.bydirection("down", client.focus) end,
              { description = "swap the focused client with the client below", group = "focus" }),
    awful.key({ modkey, "Control" }, "k", function() awful.client.swap.bydirection("up", client.focus) end,
              { description = "swap the focused client with the client above", group = "focus" }),
    awful.key({ modkey, "Control" }, "l", function() awful.client.swap.bydirection("right", client.focus) end,
              { description = "swap the focused client with the client on the right", group = "focus" }),
})
-- Custom keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
              { description = "open a terminal", group = "launcher" }),
    awful.key({ }, "Print", function() awful.spawn(screenshot_tool) end,
              { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
              { description = "run command", group = "launcher" }),
    awful.key({ modkey }, "p", menubar.show,
              {description = "show the menubar", group = "launcher"}),
})

-- Audio keys
awful.keyboard.append_global_keybindings({
    awful.key({  }, "XF86AudioRaiseVolume", function() os.execute("pamixer -i 5") end),
    awful.key({  }, "XF86AudioLowerVolume", function() os.execute("pamixer -d 5") end),
    awful.key({  }, "XF86AudioMute", function() os.execute("pamixer -t") end),
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),
    awful.key({
        modifiers   = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    }),
    awful.key({
        modifiers = { modkey, "Control" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    }),
    awful.key({
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    }),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function(c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function(c)
            c:activate { context = "mouse_click", action = "mouse_move" }
        end),
        awful.button({ modkey }, 3, function(c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey, "Control" }, "f", function (c) c.fullscreen = not c.fullscreen end,
                  { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, "Control" }, "c", function (c) c:kill() end,
                  { description = "close", group = "client" }),
        awful.key({ modkey, "Control" }, "t", function (c) c.ontop = not c.ontop end,
                  { description = "toggle keep on top", group = "client" }),
    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
-- ruled.client.connect_signal("request::rules", function()
--     -- All clients will match this rule.
--     ruled.client.append_rule({
--         id         = "global",
--         rule       = { },
--         properties = {
--             focus     = awful.client.focus.filter,
--             raise     = true,
--             screen    = awful.screen.preferred,
--             placement = awful.placement.no_overlap+awful.placement.no_offscreen
--         }
--     })
--
--     -- Add titlebars to normal clients and dialogs
--     ruled.client.append_rule({
--         id         = "titlebars",
--         rule_any   = { type = { "normal", "dialog" } },
--         properties = { titlebars_enabled = false     }
--     })
-- end)
-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move" }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize" }
        end),
    }
end)
-- }}}

-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    })
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box({ notification = n })
end)
-- }}}

client.connect_signal("request::manage", function(c)
    if c.class == "kitty" then
        c.border_width = 1
    end
end)

awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    'dex --environment Awesome --autostart;' ..
    'source ~/.zshrc;' ..
    'picom --experimental-backends --daemon'
    )
