-- global title bar    ------ holgerschurig.de/en/awesome-4.0-global-titlebar/
local mytitle = wibox.widget {
  markup = "",
  align  = "center",
  font   = "Roboto Medium 14",
  widget = wibox.widget.textbox,
}  5   local function update_title_text(c)
  local s
  if c == client.focus then
    if c.class then
      if c.name then
        s = c.name
      else
        s = c.class
      end
    else
      s = c.name
    end
    if s then
      --                      mytitle.text = s
      mytitle.text = string.sub(s, 1, 90 )

    end
  end
end
client.connect_signal("focus", update_title_text)
client.connect_signal("property::name", update_title_text)
client.connect_signal("unfocus", function (c) mytitle.markup = " " end)


--  mytitle:buttons(awful.button({ }, 2, function () if client.focus ~= nil then         client.focus:kill() end end ))
