------------------------------
--  core awesome theme  --
-------------------------------

local awful = require("awful")
local themes_path = awful.util.getdir("config").."/themes/"
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = nil
-- }}}

-- {{{ Styles
theme.font      = "Roboto Mono 12"

-- {{{ Colors
theme.fg_normal  = "#a0a0a0"
theme.fg_focus   = "#bf6161"
theme.fg_urgent  = theme.fg_normal
theme.bg_normal  = "#282c34"
theme.bg_focus   = theme.bg_normal
theme.bg_urgent  = theme.bg_normal
theme.bg_systray = theme.bg_normal
theme.accent     = "#5E81AC"
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_normal
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_normal
theme.titlebar_fg_normal = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_fg_empty = "#555555"

-- {{{ Taglist
theme.taglist_fg_empty = "#555555"
theme.taglist_fg_focus = theme.fg_normal 
--theme.taglist_bg_focus = "#484f5d"
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_font = "FontAwesome bold 15"
-- }}}

--[[ {{{ Tasklist
theme.tasklist_fg_focus = "#eeeeee"
theme.tasklist_disable-icon = true
theme.tasklist_font = "roboto mono 9"
]]
-- {{{ Notifications
-- }}}

-- {{{ Tooltips
theme.tooltip_font = "Roboto 12"
theme.tooltip_bg = "#e7e8eb"
theme.tooltip_border_color = theme.tooltip_bg
theme.tooltip_fg = "#333333"
-- }}}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
--theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width  = dpi(150)
theme.menu_border_width = (10)
theme.menu_fg_normal = "#afafaf"
theme.menu_bg_normal = theme.bg_normal
theme.menu_fg_focus = "#000000"
theme.menu_bg_focus = theme.fg_normal
theme.menu_border_color = theme.bg_normal 
-- }}}

-- {{{ Icons
-- {{{ Taglist
--theme.taglist_squares_sel   = themes_path .. "core/taglist/squarefz.png"
--theme.taglist_squares_unsel = themes_path .. "core/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "core/awesome-icon.svg"
theme.menu_submenu_icon      = themes_path .. "core/bar/submenu2.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "core/layouts/tile.svg"
theme.layout_tileleft   = themes_path .. "core/layouts/tileleft.svg"
theme.layout_tilebottom = themes_path .. "core/layouts/tilebottom.svg"
theme.layout_tiletop    = themes_path .. "core/layouts/tiletop.svg"
theme.layout_fairv      = themes_path .. "core/layouts/fair.svg"
theme.layout_fairh      = themes_path .. "core/layouts/fair.svg"
theme.layout_spiral     = themes_path .. "core/layouts/spiral.svg"
theme.layout_dwindle    = themes_path .. "core/layouts/spiral.svg"
theme.layout_max        = themes_path .. "core/layouts/max.svg"
theme.layout_fullscreen = themes_path .. "core/layouts/fullscreen.svg"
theme.layout_magnifier  = themes_path .. "core/layouts/magnifier.svg"
theme.layout_floating   = themes_path .. "core/layouts/floating.svg"
theme.layout_cornernw   = themes_path .. "core/layouts/cornernw.svg"
theme.layout_cornerne   = themes_path .. "core/layouts/cornerne.svg"
theme.layout_cornersw   = themes_path .. "core/layouts/cornersw.svg"
theme.layout_cornerse   = themes_path .. "core/layouts/cornerse.svg"
-- }}}

-- {{{ Titlebar
theme.titlebar_sticky_button_focus_active  = themes_path .. "core/titlebar/green.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "core/titlebar/green.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "core/titlebar/light_grey.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "core/titlebar/light_grey.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "core/titlebar/light_grey.png"
theme.titlebar_floating_button_normal_active = themes_path .. "core/titlebar/light_grey.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "core/titlebar/blue.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "core/titlebar/blue.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "core/titlebar/yellow.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "core/titlebar/yellow.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "core/titlebar/light_grey.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "core/titlebar/light_grey.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
