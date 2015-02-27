-- Get The Weather from Wunderground
-- tested on NodeMCU 0.9.5 build 20150108

conn=net.createConnection(net.TCP, 0) 

-- Put your own API Key in place of the xxxxx's
conn:on("connection",function(conn, payload)
            conn:send("GET /api/xxxxxxxxxx/conditions/q/CA/San_Francisco.json" 
                        .." HTTP/1.1\r\n" 
                        .."Host: api.wunderground.com\r\n" 
                        .."Connection: close\r\n"
                        .."Accept: */*\r\n" 
                        .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; )\r\n" 
                        .."\r\n"
                        )
                        end)
            
conn:on("receive", function(conn, payload)
    print(payload)
    conn:close()
    end) 
t = tmr.now()    
conn:connect(80,'api.wunderground.com') 
