-- Get The Weather from Wunderground
-- tested on NodeMCU 0.9.5 build 20150108

conn=net.createConnection(net.TCP, 0) 

-- Once connected to wensite send request
conn:on("connection",function(conn, payload)
            conn:send("GET /api/yourAPIKeyHere/astronomy/q/UK/Gravesend.json"
                        .." HTTP/1.1\r\n" 
                        .."Host: api.wunderground.com\r\n" 
                        .."Connection: close\r\n"
                        .."Accept: */*\r\n" 
                        .."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; )\r\n" 
                        .."\r\n"
                        )
end)

-- What to do once data is received back from the website
conn:on("receive", function(conn, payload)
  success = true
  process(payload)
  conn:send("ok\r\n")  
end)

--t = tmr.now()    
conn:connect(80,'api.wunderground.com') 

function process(payload)
     s = payload  
     s=(string.gsub(s, "%c+", "")) -- strip out the newline and carriage return characters
     print()
     -- TODO check valid APi return here
     
     -- sunrise
     sunriseHour, sunriseMinute = string.match(s, [["sunrise": {"hour":"(%d+)","minute":"(%d+)"]])
     print("Sunrise:\t"..sunriseHour..":"..sunriseMinute)
     -- sunset
     sunsetHour, sunsetMinute = string.match(s, [["sunset": {"hour":"(%d+)","minute":"(%d+)"]])
     print("Sunset:\t"..sunsetHour..":"..sunsetMinute)

     -- percentage of moon illuminated
     percentIlluminated = string.match(s, [["percentIlluminated":"(%d+)"]])
     print("Percent:\t"..percentIlluminated.."%")

     -- age of moon since last new moon
     age = string.match(s, [["ageOfMoon":"(%d+)"]])
     print("Age:\t\t"..age)

     -- Phase of the moon
     moonPhase = string.match(s, [["phaseofMoon":"(.-)"]])
     print("Phase:\t"..moonPhase)
end






