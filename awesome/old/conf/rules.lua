-- Rules, signals, smart gaps etc

local awful =require("awful")
local beautiful = require("beautiful")

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
		    --          "Kruler",
		    --          "MessageWin",  -- kalarm.
		    --          "Sxiv",
		    "Wpa_gui",
		    "pinentry",
		    --	  "Thunar",
		    "veromix",
		    "xtightvncviewer"},

		    name = {
			    "Event Tester",  -- xev.
		    },
		    role = {
			    "AlarmWindow",  -- Thunderbird's calendar.
			    "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
		    }
	    }, properties = { floating = true, 
	    placement = awful.placement.centered 
    }
     },

     -- Add titlebars to normal clients and dialogs
     { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    --[[ remove Firefox border 
    { rule = { class = "Firefox" },
    properties = { border_width = 0 } },]]
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and
		not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
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

	awful.titlebar(c) : setup {
		{
		{ -- Left
		--            awful.titlebar.widget.iconwidget(c),
		buttons = buttons,
		layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
		{ -- Title
		align  = "center",
		widget = awful.titlebar.widget.titlewidget(c)
		},
		buttons = buttons,
		layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
		awful.titlebar.widget.stickybutton   (c),
		awful.titlebar.widget.maximizedbutton(c),
		--awful.titlebar.widget.ontopbutton    (c),
		--awful.titlebar.widget.closebutton    (c),
		awful.titlebar.widget.floatingbutton (c),
		layout = wibox.layout.fixed.horizontal()
	    	},

    	    layout = wibox.layout.align.horizontal
    },
    right = 2,
    widget = wibox.container.margin
}    

-- Hide the titlebar if we are not floating
local l = awful.layout.get(c.screen)
if not (l.name == "floating" or c.floating) then
	awful.titlebar.hide(c)
end

end)

-- smart gaps
local function get_num_tiled(t, s)
	s = s or t.screen
	local num_tiled
	if t == s.selected_tag then
		num_tiled = #awful.client.tiled(s)
	else
		num_tiled = 0
		for _, tc in ipairs(t:clients()) do
			if not tc.floating
				and not tc.fullscreen
				and not tc.maximized_vertical
				and not tc.maximized_horizontal
				then
					num_tiled = num_tiled + 1
				end
			end
		end
		return num_tiled
	end


awful.tag.object.get_gap = function(t)
	t = t or awful.screen.focused().selected_tag
	if get_num_tiled(t) == 1 then
		return  0 
	end
	return awful.tag.getproperty(t, "useless_gap") or beautiful.useless_gap or  0  
end

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
		client.focus = c
	end
end)

client.connect_signal("property::floating", function (c)
	if c.floating then
		awful.titlebar.show(c)
	else
		awful.titlebar.hide(c)
	end
end)


client.connect_signal("property::fullscreen", function(c)
	if c.fullscreen then
		gears.timer.delayed_call(function()
			if c.valid then
				c:geometry(c.screen.geometry)
			end
		end)
	end
end)


-- awesome-copycats smart border
--------------------------------------------------------------------------------

-- No border for maximized clients
function border_adjust(c)
	if c.maximized then -- no borders if only 1 client visible
		c.border_width = 0
	elseif #awful.screen.focused().clients > 1 then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_focus
	else
		c.border_width = 0 
	end
end
-- No border for maximized clients
function border_unadjust(c)
	if c.maximized then -- no borders if only 1 client visible
		c.border_width = 0
	elseif #awful.screen.focused().clients > 1 then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_normal
	else
		c.border_width = 0 
	end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", border_unadjust)
--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

