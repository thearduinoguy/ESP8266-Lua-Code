wifi.setmode(wifi.STATION)
wifi.sta.config("Earthshine","AndromedaBootesCancerDraco")

uart.setup( 0, 115200, 8, 0, 1, 0, 1 )
print("NodeMCU Welcome")

tmr.alarm(0, 60000, 1, function() dofile('googleTime.lua') end )


