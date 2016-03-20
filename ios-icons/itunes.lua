local itunes = {
    -- sleep between itunes http reqs
    pause_between_downloads = 0.5,
}

local cache = require 'ios-icons.cache'
local io = require "io"
local json = require "json"
local socket = require "socket"
local http = require "socket.http"
http.USERAGENT = "LuaSocket - ios springboard client" 


local function sleep(sec)
    socket.select(nil, nil, sec)
end

-- sadly had to use a private api here, 
-- apple's official one doesn't (atow tbomk)
-- support lookup by bundleID
local itunes_url = function(icon)
    return ("http://itunes.apple.com/" .. "lookup?bundleId=" .. icon.id)
end

-- json cache store. * I have no idea if apple own a 
-- banstick or under what conditons said banstick would be
-- used * (although I expect they do and barrier for entry 
-- would be low)
itunes.cache = cache.new('./.iTunesJson', function(i)
                            if not i or not i.id then return nil end
                            return i.id .. '_itunes.json' end)


local rate_limit = function()
    local last_fetch = itunes.last_fetch
    if not last_fetch then last_fetch = -100 end
    if (os.clock() - last_fetch) < 1 then
        sleep(itunes.pause_between_downloads)
    end
    itunes.last_fetch = os.clock()
end

local add_itunes_data = function(icon)  
    local raw = nil ; local cache = itunes.cache
    if cache then raw = cache.get(icon) end

    if not raw then
        rate_limit()
        local url = itunes_url(icon)
        raw = http.request(itunes_url(icon))
        if cache then cache.set(icon, raw) end
    end

    if raw then
        data = json.decode(raw) 
        if data.results and #data.results == 1 then
            icon.data = data.results[1]
        end
    end
    return data
end

-- adds itunes data to ALL icons for which it can.
-- this is likely to be time consuming on the first run
-- (expect ~2 seconds per app)
local add_itunes_to_all = function(icons, on_process)   
    icons:visit(function(icon)
        icon:add_itunes_data()
        if on_process then on_process(icon) end
    end)
end


function itunes.on_icons(icons)
    if not icons then error("no icons provided!") end
    if not icons.visit then error("unexpected value found for icons!") end

    icons:visit(function(icon)
        if icon["id"] then 
            icon.add_itunes_data = add_itunes_data
        else
            icon.add_itunes_data = function() end
        end
    end)
    icons.add_itunes_data = add_itunes_to_all

    icons.itunes_cache = function() return itunes.cache end
end

return itunes
