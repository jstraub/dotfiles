-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
--    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
  settings = {
   { names = {"main","dev1","dev2","dev3","misc"},
     layout ={layouts[3],layouts[3],layouts[3],layouts[3],layouts[3]}
   },
   { names = {"mail","gtd","misc"},
     layout ={layouts[7],layouts[7],layouts[7]}
   }
  }
}
screens = {}
if screen.count() == 3 then
  screens = { "side", "work", "work"}
  screenOrg = {
    gtd =  {id=1,tag=2},
    mutt = {id=1,tag=1},
    plots ={id=1,tag=3},
  }
elseif screen.count() == 2 then
  screens = { "side", "work"}
  screenOrg = {
    gtd =  {id=1,tag=2},
    mutt = {id=1,tag=1},
    plots ={id=1,tag=2},
  }
else
  screens = { "work"}
  screenOrg = {
    gtd =  {id=1,tag=2},
    mutt = {id=1,tag=1},
    plots ={id=1,tag=5},
  }
end
-- Each screen has its own tag table.
for s,kind in pairs(screens) do
  if kind == "work" then
    tags[s] = awful.tag(tags.settings[1].names, s, tags.settings[1].layout)
  else
    tags[s] = awful.tag(tags.settings[2].names, s, tags.settings[2].layout)
  end
end
-- }}}
-- {{{ Wallpaper
if beautiful.wallpaper then
    --for s = 1, screen.count() do
    for s,kind in pairs(screens) do
      if kind == "work" then
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
      else
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
      end
    end
end
-- }}}

require("taskBar")

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
   -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

require("keyBindings")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
--                      maximized_vertical   = false,
--                      maximized_horizontal = false,
                     size_hints_honor = false, -- remove space between windows
                     buttons = clientbuttons } },
    { rule_any = { class = {"Rgb", "Normals","Dbg"} }, 
      properties = { floating = false, tag = tags[screenOrg.plots.id][screenOrg.plots.tag]} }, -- opencv imshows()
    { rule = { class = "pangolin" }, properties = { floating = true } },
    { rule = { class = "gimp" }, properties = { floating = true } },
    { rule = { class = "feh" }, properties = { floating = true } },
    { rule = { class = "X-terminal-emulator" }, 
      properties = { floating = false, 
      maximized_vertical = false, 
      maximized_horizontal = false
    } }, 
    { rule = { class = "Okular" }, 
      properties = { floating = false, 
--       maximized_vertical = false, 
--       maximized_horizontal = false
    }, 
      callback = function(c) 
        local count = 0
        for tag in pairs(tags) do count = count + 1 end
        awful.client.movetotag(tags[count-1][awful.tag.getidx()], c) 
      end },
    { rule = { name = "gtd" },   
      properties = { tag = tags[screenOrg.gtd.id][screenOrg.gtd.tag] } },
    { rule = { name = "mutt" },  properties = { tag = tags[screenOrg.mutt.id][screenOrg.mutt.tag] } }
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[2][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

require("startup")
