-----------------------------------------------------------------------------------------
--
--          AwesomeWM rules config                                        
--
------------------------------------------------------------------------------------------

-- libraries
local awful = require("awful")
local beautiful = require("beautiful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   size_hints_honor = false,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  { rule_any = {
    instance = {
      --          "DTA",  -- Firefox addon DownThemAll.
      "copyq",  -- Includes session name in class.
    },
    class = {
      "Arandr",
      "Gpick",
      --          "Sxiv",
      "Wpa_gui",
      "pinentry",
      "Blueman-manager",
      "Nautilus",
      "Nemo",
      "dolphin",
      "xtightvncviewer"},

    name = {
      "Event Tester",  -- xev.
    },
    role = {
      "AlarmWindow",  -- Thunderbird's calendar.
--      "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    }
  }, properties = { floating = true, 
                    placement = awful.placement.centered 
  }
  },


-- Titlebars OFF (explicitly)
    -- Titlebars of these clients will be hidden regardless of the theme setting
    { rule_any = {
        class = {
            "qutebrowser",
            "Spotify",
            "Nautilus",
            --"discord",
            --"TelegramDesktop",
            "Firefox",
            "Steam",
            "Lutris",
            "Chromium",
            "Thunderbird",
        },
    }, properties = {},
    callback = function (c)
            awful.titlebar.hide(c)
    end
    },



 { rule = { class = "mpv" },
    properties = { tag = awful.tag.gettags(1)[9], switchtotag = true, fullscreen=true } },
 { rule = { class = "Spotify" },
    properties = { tag = awful.tag.gettags(1)[8], switchtotag = true } },


  --[[ 	{ rule = { class = "streamlink-twitch-gui" },
  properties = { callback = function(c)
  awful.spawn('termite -e weechat', {tag = awful.tag.gettags(1)[7],}) end } },
  ]]


  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" } }, 
    properties = { titlebars_enabled = true } }
}
-- }}}


return rules
