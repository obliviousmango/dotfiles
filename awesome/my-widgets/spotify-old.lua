local awful = require("awful")
local wibox = require("wibox")

-- infos from mpris clients such asfour sea spotify and VLC
-- based on https://github.com/acrisci/playerctl
local mpris, mpris_timer = awful.widget.watch(
{ awful.util.shell, "-c", "playerctl status && playerctl metadata" },
6,
function(widget, stdout)
	local escape_f  = require("awful.util").escape
	local mpris_now = {
		state        = "N/A",
		artist       = "N/A",
		title        = "N/A",
		art_url      = "N/A",
		album        = "N/A",
		album_artist = "N/A"
	}

	mpris_now.state = string.match(stdout, "Playing") or
	string.match(stdout, "Paused")  or "N/A"

	for k, v in string.gmatch(stdout, "'[^:]+:([^']+)':[%s]<%[?'([^']+)'%]?>")
		do
			if     k == "artUrl"      then mpris_now.art_url      = v
			elseif k == "artist"      then mpris_now.artist       = escape_f(v)
			elseif k == "title"       then mpris_now.title        = escape_f(v)
			elseif k == "album"       then mpris_now.album        = escape_f(v)
			elseif k == "albumArtist" then mpris_now.album_artist = escape_f(v)
				end
			end

			-- customize here
			if mpris_now.state == "Playing" then widget:set_text(string.sub(mpris_now.artist .. " | " .. mpris_now.title, 1, 40) .. "    ")
			else
				widget:set_text("")
			end
		end
		)
	mpris.font = "Roboto Medium 14"


local spotify = wibox.widget {
	layout = wibox.container.constraint,
	width = 500,
		{ widget = mpris,    },
	}
	spotify:buttons(awful.button({ }, 1, function () awful.spawn("playerctl pause") end))


return spotify
