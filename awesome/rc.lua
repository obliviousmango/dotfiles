---------------------------------------------------------------------------------------
--
--          AwesomeWM config                                        
--
---------------------------------------------------------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local revelation=require("revelation")
local dpi = require("beautiful.xresources").apply_dpi
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-----------------------------------------------------------------------------
-- {{{ Error handling
-----------------------------------------------------------------------------
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
                     text = tostring(err) })
    in_error = false
  end)
end
-- }}}


-----------------------------------------------------------------------------
-- Variable definitions
-----------------------------------------------------------------------------

local themes = {
  "282c34", -- 1
  "blue",   -- 2
  "light",  -- 3
  "dark",   -- 4
  "pink",   -- 5
  "black",  -- 6
}

local chosen_theme = themes[4]
terminal = "alacritty"
local editor = os.getenv("EDITOR") or "vim"
local editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

-- revelation client overview
revelation.init()

-- Apply theme variables
naughty.config.padding = dpi(20)
naughty.config.spacing = dpi(0)
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.border_width = dpi(2)

-----------------------------------------------------------------------------
-- Autostart
-----------------------------------------------------------------------------
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

--------------------------------------------------------------------------------
-- Table of layouts to cover with awful.layout.inc, order matters.
--layouts in /usr/share/awesome/lib/awful/layout/suit  
--------------------------------------------------------------------------------
awful.layout.layouts = {
  awful.layout.suit.floating,
--  awful.layout.suit.tile,
--  awful.layout.suit.fair,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
--  awful.layout.suit.spiral,
--  awful.layout.suit.corner.nw,
}
-- }}}

--------------------------------------------------------------------------------
-- Helper functions
--------------------------------------------------------------------------------
local function client_menu_toggle_fn()
  local instance = nil

  return function ()
    if instance and instance.wibox.visible then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ theme = { width = 250 } })
    end
  end
end
-- }}}


naughty.config.notify_callback = function(args)
  if args.icon then
    args.icon_size = 80
  end
  return args
end

-- rename focused tag 
local prev_tag = 1
tag.connect_signal("property::selected", function(t)
  if t.selected then
    awful.screen.focused().tags[prev_tag].name = ""
    prev_tag = awful.screen.focused().selected_tag.index
    --	    awful.screen.focused().selected_tag.name = ""
    awful.screen.focused().tags[prev_tag].name = ""
  end
end)



--------------------------------------------------------------------------------
-- Menu
--------------------------------------------------------------------------------
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() return false, hotkeys_popup.show_help end},
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ 
  items = { 
    { "Awesome", myawesomemenu},-- beautiful.awesome_icon },
    { "Open Terminal", terminal },
    { "Change Wallpaper", function() awesome.spawn("nitrogen") end},
    { "Shutdown", function() awesome.spawn("systemctl poweroff") end }, 
    { "Reboot", function() awesome.spawn("systemctl reboot") end } 
  }
})

mylauncher = wibox.layout.margin(awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu }), 4,4,5,5)

--------------------------------------------------------------------------------
-- {{{ Wibar
--------------------------------------------------------------------------------
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({ }, 2, function() if client.focus ~= nil then client.focus:kill() end end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end)
    --awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    --awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    --[[    awful.button({ }, 1, function (c)
    if c == client.focus then
    c.minimized = true
    else
    -- Without this, the following
    -- :isvisible() makes no sense
    c.minimized = false
    if not c:isvisible() and c.first_tag then
    c.first_tag:view_only()
    end
    -- This will also un-minimize
    -- the client, if needed
    client.focus = c
    c:raise()
    end
    end),
    ]]
    awful.button({ }, 3, client_menu_toggle_fn()),
    awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
    end))


--------------------------------------------------------------------------------
-- {{{ Screen
--------------------------------------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "", "", "", "", "", "", "", "", "" }, s, awful.layout.layouts[2])
--  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[2])
  beautiful.taglist_spacing = 6


  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = wibox.container.margin(awful.widget.layoutbox(s), 4,4,5,5)
  s.mylayoutbox:buttons(gears.table.join(
      awful.button({ }, 1, function () awful.layout.inc( 1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end),
      awful.button({ }, 4, function () awful.layout.inc( 1) end),
      awful.button({ }, 5, function () awful.layout.inc(-1) end)))

--------------------------------------------------------------------------------
-- {{{ Widgets
-------------------------------------------------------------------------------
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
  
  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons) --, {disable_task_name = true})
  
  -- Keyboard map indicator and switcher
  --mykeyboardlayout = awful.widget.keyboardlayout()
  
  -- Create a textclock widget
  mytextclock = wibox.widget.textclock(" %a.%d %H:%M ", 10 )
  mytextclock.font = "Roboto Mono Medium 13"
  
  -- Systray
  local systray = wibox.layout.margin(wibox.widget.systray(), 1,1,1,1)
  beautiful.systray_icon_spacing = 9
  --systray.forced_width = 95
  
  -- Separator
  local separator = wibox.widget.textbox()
  separator.text = " "
  
  -- Update-button
  local upicon = wibox.widget.textbox()
  upicon.text = " "
  upicon.font = "Roboto Mono regular 12"
  upicon:buttons(awful.button({ }, 1, function () awful.util.spawn('alacritty -e "yay"') end))
  
  -- Updates
  local updates = wibox.widget.textbox()
  updates.font = "Roboto Mono Medium 12"
  gears.timer {
    timeout   = 600,
    call_now  = true,
    autostart = true,
    callback  = function()
      awful.spawn.with_line_callback([[bash -c 'checkupdates+aur | wc -l']], {
        stdout = function(line)
          updates.text = " "..line.." "
        end}) end }
  
  updates:buttons(awful.button({ }, 1, function () awful.spawn.with_line_callback([[bash -c 'checkupdates+aur']], 
                                                                                  { 
                                                                                    stdout = function(line) naughty.notify { text = line } end
                                                                                  }) 
  end))
  
  -- mpd widget
  local mpd = require("my-widgets.mpd")
  
  -- Spotify widget
  local spotify = require("my-widgets.spotify")
  
  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })
  
  
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      separator,
      mylauncher,
      separator,
      s.mytaglist,
      s.mypromptbox,
      separator,
    },
    { -- Middle widget
--      s.mytasklist,
      layout = wibox.container.margin,
      --      left =  55,
      bottom =  2,
      --left =  0,
      --      right = 15,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      separator,
      spotify,
      mpd,
--      updates,
--      upicon,
      --mykeyboardlayout,
      separator,
      systray,
      mytextclock,
      s.mylayoutbox,
      separator,
    },
  }
  end)
  -- }}}

--------------------------------------------------------------------------------
-- {{{ Mouse bindings & Key bindings
--------------------------------------------------------------------------------
local hotkeys = require("keys-config") -- load hotkey config

beautiful.hotkeys_font = "Roboto 11"
beautiful.hotkeys_description_font = "Roboto 11"

--------------------------------------------------------------------------------
-- {{{ Rules
--------------------------------------------------------------------------------
local rules = require("rules-config") -- load rules config

--------------------------------------------------------------------------------
-- {{{ Signals
--------------------------------------------------------------------------------
local signals = require("signals-config") -- load signals config

