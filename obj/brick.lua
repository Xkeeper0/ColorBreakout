--[[
Brick object and methods.
]]

local constants = require('/lib/const')

local Brick = {}
Brick.__index = Brick

setmetatable(Brick, {
	__call = function (class, ...)
		return class._const(...)
	end,
})

function Brick._const(A, B, C, ...)
	local self = setmetatable({}, Brick)
	if (A == nil or B == nil or C == nil) then error("Brick defined with fewer than three vertices") end
	if #A ~= 2 then error("Brick: Vertex 1 detected with too few or too many coordinates") end
	if #B ~= 2 then error("Brick: Vertex 2 detected with too few or too many coordinates") end
	if #C ~= 2 then error("Brick: Vertex 3 detected with too few or too many coordinates") end
	self.vertices = {A, B, C}
	for i,v in ipairs({...}) do
		if #v ~= 2 then error("Brick: Vertex " .. i+3 .. " detected with too few or too many coordinates") end
		table.insert(self.vertices, v)
	end
	return self
end

function Brick:draw()
	if love.graphics then
		love.graphics.setColor(constants.COLOR_CYAN)

		local verts = {}
		for i,v in ipairs(self.vertices) do
			for j,w in ipairs(v) do
				table.insert(verts, w)
			end
		end

		love.graphics.polygon('fill', verts)
	end
end

function Brick:update(dt)
	-- TODO
end

return Brick
