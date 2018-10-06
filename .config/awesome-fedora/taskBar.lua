local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
-- local blingbling = require("blingbling")
local net_widgets = require("net_widgets")
-- require("volume")

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function ()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({
        theme = { width = 250 }
      })
    end
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)

--net_wireless = net_widgets.wireless({interface="wlan0"})
--net_wired = net_widgets.indicator({
--  interfaces  = {"eth2"},
--  timeout     = 5
--})

-- memwidget = awful.widget({ type = 'textbox', name = 'memwidget' })
-- vicious.register(memwidget, vicious.widgets.mem, ' [ <span color="white">mem:</span> $1% - $2Mb/$3Mb ]')
-- 
-- cpuwidget = awful.widget({ type = 'textbox', name = 'cpuwidget' })
-- vicious.register(cpuwidget, vicious.widgets.cpu, ' [ <span color="white">cpu:</span> $1% $2% $3% $4% ]')
-- 
-- netwidget = awful.widget({ type = 'textbox', name = 'netwidget' })
-- vicious.register(netwidget, vicious.widgets.net, ' <span color="white">net</span>: ${eth1 down} / ${eth1 up} [ ${eth1 rx} //  ${eth1 tx} ]', nil, nil, 3)
-- 
-- wifiwidget = awful.widget({ type = 'textbox', name = 'wifiwidget' })
-- vicious.register(wifiwidget, vicious.widgets.wifi, ' [ <span color="white">wifi</span>: ${ssid}  ${link}/70 ]', 3, 'wlan0')
-- 

gmailIcon = wibox.widget.imagebox()
gmailIcon:set_image(awful.util.getdir("config") .. "/icons/gmail.png")

gmailwidget = wibox.widget.textbox()
vicious.register(gmailwidget, vicious.widgets.mdir, 
  ' $1 $2 ', 
  3, 
  {"/home/jstraub/mail/gmail/INBOX", "/home/jstraub/mail/gmail/0_actions"}
)

csailIcon = wibox.widget.imagebox()
csailIcon:set_image(awful.util.getdir("config") .. "/icons/MITXS.png")
csailmailwidget = wibox.widget.textbox()
vicious.register(csailmailwidget, vicious.widgets.mdir, 
  ' $1 $2 ', 
  3, 
  {"/home/jstraub/mail/csail/INBOX","/home/jstraub/mail/csail/INBOX.0_actions"}
)

-- Initialize widget
memwidget = awful.widget.progressbar()
-- Progressbar properties
memwidget:set_width(10)
memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#AECF96"}, {0.5, "#88A175"}, 
                    {1, "#FF5656"}}})
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 2)

-- Initialize widget
cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, 
to = {10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1,
  "#AECF96" }}})
-- cpuwidget = blingbling.line_graph({ 
--   height = 18, width = 200,
--   show_text = true, label = "$percent %",
--   rounded_size = 0.3,
--   graph_background_color = "#00000033"}
-- )
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1",2)
--bind a top popup on the graph 
-- blingbling.popups.htop(cpuwidget, { terminal = "urxvt"})
--   { title_color = beautiful.notify_font_color_1, 
--   user_color = beautiful.notify_font_color_2, 
--   root_color = beautiful.notify_font_color_3, 
--   terminal = "terminator"})
--

--netwidget = wibox.widget.textbox()
-- -- Register widget
--vicious.register(netwidget, vicious.widgets.net, 
--  ' <span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 3
--)

batterywidget = wibox.widget.textbox()    
batterywidget:set_text("Battery")    
batterywidgettimer = timer({ timeout = 5 })    
batterywidgettimer:connect_signal("timeout",    
  function()    
    fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))    
    batteryStatus = fh:read("*l")
    if batteryStatus == nil then
      batterywidget:set_text("none")
    else
      batterywidget:set_text(batteryStatus)    
    end
    fh:close()    
  end    
)    
batterywidgettimer:start()

-- netGraph = awful.widget.graph()
-- netGraph:set_width(50)
-- netGraph:set_background_color("#494B4F")
-- netGraph:set_color({ type = "linear", from = { 0, 0 }, 
-- to = {10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1,
--   "#AECF96" }}})
-- vicious.register(netGraph, vicious.widgets.net, "${wlan0 down_kb}",2)

separator = wibox.widget.textbox()
separator:set_text(" : ")
 -- Register widget

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])
    if s == 1 then 
      left_layout:add(separator)
      left_layout:add(wibox.widget.systray()) 
      left_layout:add(separator)
    end

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
--    screenNr = wibox.widget.textbox()
--    screenNr:set_text(s)
--    right_layout:add(separator)
--    right_layout:add(screenNr)
--    right_layout:add(separator)
--    right_layout:add(gmailIcon)
--    right_layout:add(gmailwidget)
--    right_layout:add(csailIcon)
--    right_layout:add(csailmailwidget)
--    right_layout:add(separator)
--    right_layout:add(net_wired)
--    right_layout:add(net_wireless)
--    right_layout:add(netwidget)
--     right_layout:add(netGraph)
    right_layout:add(separator)
    right_layout:add(batterywidget)
    right_layout:add(separator)
    right_layout:add(cpuwidget)
    right_layout:add(separator)
    right_layout:add(memwidget)
--     right_layout:add(separator)
--     right_layout:add(volume_widget)
    right_layout:add(separator)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}
