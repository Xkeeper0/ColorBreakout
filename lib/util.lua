--[[
    Misc. Lua core changes and utility functions.

    Code contributed by Yukita Mayako
]]

-- I will not be using the global namespace.
-- EVERYTHING comes from somewhere in the file it's declared in.
setmetatable(_G,{__newindex=function(self,k,v) error("Do not make '"..k.."' a global variable.") end})

-- I will not be using pi.
-- Pi is wrong.
math.tau = (math.pi*2)
math.pi = nil

do -- string+string == string..string
	local STRING = getmetatable("")
	STRING.__add = function(o1,o2)
		return tostring(o1)..tostring(o2)
	end
end

-- Forward compatibility with Love 0.9.0+
if not love.window then
    local l = {
        "setCaption","getCaption",
        "setMode","getMode","checkMode","getModes",
        "toggleFullscreen",
        "getWidth","getHeight",
        "hasFocus","isCreated"
    }
    love.window = {}
    for _,v in pairs(l) do
        love.window[v] = love.graphics[v]
        love.graphics[v] = nil
    end
end
