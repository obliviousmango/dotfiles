-------------------------------------------------
-- mpd Widget for Awesome Window Manager
-- Shows currently playing song on Spotify for Linux client

-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
 local mpc = require("mpc")
 local textbox = require("wibox.widget.textbox")
 local timer = require("gears.timer")
 local mpd_widget = textbox()
 local mpd_widget = wibox.widget {
   text = "",
   font = "Roboto Medium 14",
   widget = wibox.widget.textbox,
 }
 local state, title, artist, file = "stop", "", "", ""
 local function update_widget()
   local text = "  "
   text = text .. tostring(artist or "") .. " - " .. tostring(title or "")
   if state == "pause" then
     text = ""
   end
   if state == "stop" then
     text = ""
   end
  mpd_widget.text = text
 end
 local connection
 connection = mpc.new(nil, nil, nil, error_handler,
                      "status", function(_, result)
                        state = result.state
                      end,
                      "currentsong", function(_, result)
                        title, artist, file = result.title, result.artist, result.file
                        pcall(update_widget)
                      end)

return mpd_widget
