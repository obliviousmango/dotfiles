-----------------------------------------------------------------------------------------
--
--          AwesomeWM hotkey config                                        
--
------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local revelation=require("revelation")
local prev_t = 1

local hotkeys = {}
--------------------------------------------------------------------------------
-- {{{ Mouse bindings & Key bindings
--------------------------------------------------------------------------------
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
    --    awful.button({ }, 4, awful.tag.viewnext),
    --    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "[",      function() awesome.spawn("systemctl poweroff") end,
              {description="shutdown", group="awesome"}),
    awful.key({ modkey, "Shift"   }, "]",      function() awesome.spawn("systemctl reboot") end,
              {description="reboot", group="awesome"}),
    awful.key({ modkey,           }, "p",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, 	      }, "i", rename_tag,
              {description = "rename the current tag", group = "tag"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    awful.key({ modkey }, "v", function () mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible end,
              {description ="toggle wibar", group="awesome"}),
    awful.key({ modkey,           }, "`",      revelation),
    awful.key({ modkey,           }, "j",
              function ()
                awful.client.focus.byidx( 1)
              end,
              {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
              function ()
                awful.client.focus.byidx(-1)
              end,
              {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "m", function () mymainmenu:show({ coords = { x = 0, y = 0 } }) end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey, "Control"           }, "Tab",
              function ()
                awful.client.focus.history.previous()
                if client.focus then
                  client.focus:raise()
                end
              end,
              {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,      }, "/", function () awful.spawn("sp play")  end,
              {description = "spotify toggle", group = "launcher"}),
    awful.key({ modkey,      }, ",", function () awful.spawn("sp prev")  end,
              {description = "spotify previous", group = "launcher"}),
    awful.key({ modkey,      }, ".", function () awful.spawn("sp next")  end,
              {description = "spotify next", group = "launcher"}),
    awful.key({ modkey, "Shift"          }, "/", function () awful.spawn("mpc toggle")  end,
              {description = "mpc toggle", group = "launcher"}),
    awful.key({ modkey,      "Shift"     }, ",", function () awful.spawn("mpc prev")  end,
              {description = "mpc previous", group = "launcher"}),
    awful.key({ modkey,  "Shift"         }, ".", function () awful.spawn("mpc next")  end,
              {description = "mpc next", group = "launcher"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,  }, "f", function() awful.spawn("nautilus") end,
              {description = "Thunar", group = "launcher"}),
    awful.key({ modkey,  }, "b", function() awful.spawn("rofi-bluetooth") end,
              {description = "rofi bluetooth", group = "launcher"}),
    awful.key({ modkey,  }, "Print", function() awful.spawn("i3-scrot") end,
              {description = "screenshot", group = "launcher"}),
    awful.key({ modkey,  }, "c", function() awful.spawn("google-chrome-stable --enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter") end,
              {description = "chromium", group = "launcher"}),
    awful.key({ modkey, "Shift"  }, "c", function() awful.spawn("google-chrome-stable --enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter -incognito") end,
              {description = "chrome", group = "launcher"}),
    awful.key({ modkey,  }, "s",  function() awful.spawn("spotify") end,
              {description = "spotify", group = "launcher"}),
    awful.key({ modkey,  }, "r", function() awful.spawn("rofi -show calc -modi calc -no-show-match -no-sort") end,
              {description = "calculator", group = "launcher"}),
    awful.key({ modkey,  }, "w", function() awful.spawn("rofi -modi window,run,drun -show window -matching 'fuzzy'") end,
              {description = "window switcher", group = "launcher"}),
    awful.key({ modkey,  }, "d", function() awful.spawn("rofi -modi window,run,drun -show drun -matching 'fuzzy'") end,
              {description = "rofi", group = "launcher"}),
    awful.key({ modkey,  }, "e", function() awful.spawn("rofi -show emoji -modi emoji") end,
              {description = "emoji", group = "launcher"}),
    awful.key({modkey, }, "q", function() awful.spawn("rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'") end,
              {description = 'show clipboard', group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "x", function () awful.spawn("betterlockscreen -l") end,
              {description = "lock screen", group = "awesome"}),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
--[[    awful.key({ modkey, "Control" }, "m",
              function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                  client.focus = c
                  c:raise()
                end
              end,
              {description = "restore minimized", group = "client"}),

    --[[ Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    ]]
    awful.key({ modkey, "Shift" }, "x",
              function ()
                awful.prompt.run {
                  prompt       = "Run Lua code: ",
                  textbox      = awful.screen.focused().mypromptbox.widget,
                  exe_callback = awful.util.eval,
                  history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
              end,
              {description = "lua execute prompt", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"    }, "f",
              function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
              end,
              {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "x",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"           }, "s",      function (c) c.sticky = not c.sticky            end,
              {description = "sticky", group = "client"}),
    awful.key({ modkey, "Shift"           }, "m",
              function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
              end ,
              {description = "minimize", group = "client"}),
	      
    awful.key({ modkey,           }, "n",
              function (c)
                c.maximized = not c.maximized
                c:raise()
              end ,
              {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
              function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
              end ,
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "n",
              function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
              end ,
              {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
                                -- View tag only.
                                awful.key({ modkey }, "#" .. i + 9,
                                          function ()
                                            local screen = awful.screen.focused()
                                            local tag = screen.tags[i]
                                            if tag then
                                              tag:view_only()
                                            end
                                          end,
                                          {description = "view tag #"..i, group = "tag"}),
                                
                                --[[ View spotify tag only.
                                awful.key({ modkey }, "t",
                                          function ()
                                            local screen = awful.screen.focused()
                                            local tag = screen.tags[8]
                                            if tag:clients()==nil then
                                              tag:view_only()
				      		else
						awful.spawn("spotify")	
                                            end
                                          end,
                                          {description = "view tag 8"..i, group = "tag"}),
					  ]] 
                                -- Toggle tag display.
                                awful.key({ modkey, "Control" }, "#" .. i + 9,
                                          function ()
                                            local screen = awful.screen.focused()
                                            local tag = screen.tags[i]
                                            if tag then
                                              awful.tag.viewtoggle(tag)
                                            end
                                          end,
                                          {description = "toggle tag #" .. i, group = "tag"}),
                                -- Move client to tag.
                                awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                          function ()
                                            if client.focus then
                                              local tag = client.focus.screen.tags[i]
                                              if tag then
                                                client.focus:move_to_tag(tag)
                                              end
                                            end
                                          end,
                                          {description = "move focused client to tag #"..i, group = "tag"}),
                                -- Toggle tag on focused client.
                                awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                          function ()
                                            if client.focus then
                                              local tag = client.focus.screen.tags[i]
                                              if tag then
                                                client.focus:toggle_tag(tag)
                                              end
                                            end
                                          end,
                                          {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- End
-----------------------------------------------------------------------------------------------------------------------
return hotkeys
