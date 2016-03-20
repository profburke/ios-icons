local format = string.format
local cache = {}

-- add a function to get a list of keys
-- add delete function
-- what about a protocol so that we can have caches with a backend other than the file system?
-- (then what about Lua FUSE?)


function cache.new(path, keytransform)
   assert(type(path) == 'string' and #path > 0, 'path must be a non-empty string')
   assert(type(keytransform) == 'nil' or type(keytransform) == 'function', 'keytransform must be a function')
   
   local c = { }
   
   _,_,rc = os.execute('test -d ' .. path)
   if rc == 1 then os.execute('mkdir -p ' .. path) end

   c.keytransform = keytransform or function(k) return k end
   c.key = function(k)
      local kprime = c.keytransform(k)
      if not kprime then return nil end
      return format('%s/%s', path, kprime)
   end
   
   c.get = function(k, generate)
      local data = nil
      local key = c.key(k)
      if not key then error('invalid key: ' .. tostring(k)) end
      
      local fd = io.open(key, "rb")
      if fd then data = fd:read("*all") ; fd:close() end
      if not data and type(generate) == "function" then
         data = generate(k)
         c.store(k, data)
      end
      return data        
   end
   
   c.set = function(k, v)
      local key = c.key(k)
      if not key then error('invalid key: ' .. tostring(k)) end
      
      local fd = io.open(key, "wb")
      fd:write(v)
      fd:close()
   end
   
   setmetatable(c, {
                   __tostring = function() return "cache[" .. path .. "]" end,
                   })
   return c
end


return cache
