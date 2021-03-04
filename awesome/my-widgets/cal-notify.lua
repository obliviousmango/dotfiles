-- Create a calendar popup
local cal_notification
mytextclock:connect_signal("button::release",
                           function()
                             if cal_notification == nil then
                               awful.spawn.easy_async([[bash -c "ncal -3C | sed 's/_.\(.\)/+\1-/g'"]],
                                                      function(stdout, stderr, reason, exit_code)
                                                        cal_notification = naughty.notify{
                                                          text = string.gsub(string.gsub(stdout, 
                                                                                         "+", "<span foreground='#cf564e'>"), 
                                                                             "-", "</span>"),
                                                          font = "Roboto Mono Medium 12",
                                                          timeout = 0,
                                                          width = auto,
                                                          destroy = function() cal_notification = nil end
                                                        }
                                                      end
                               )
                             else
                               naughty.destroy(cal_notification)
                             end
                           end)


