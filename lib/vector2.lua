--[[
	2D Vect functions.
]]

local Vect = {}
Vect.__index = Vect
Vect.__eq = function (a, b)
	return (a.x == b.x and a.y == b.y)
end
Vect.__unm = function (a)
	return Vect(-(a.x), -(a.y))
end
Vect.__add = function (a, b)
	return Vect(a.x + b.x, a.y + b.y)
end
Vect.__sub = function (a, b)
	return Vect(a.x - b.x, a.y - b.y)
end
Vect.__mul = function (a, b)
	if (type(a) == "number" and type(b) == "table") then
		return Vect(a * b.x, a * b.y)
	elseif (type(a) == "table" and type(b) == "number") then
		return Vect(a.x * b, a.y * b)
	else error("Invalid data type used with Vect multiply (expected Vect * number or number * Vect)") end
end
Vect.__div = function (a, b)
	if (type(a) == "table" and type(b) == "number") then
		return Vect(a.x / b, a.y / b)
	else error("Invalid data type used with Vect divide (expected Vect / number)") end
end
Vect.__tostring = function (a)
	return "<" .. a.x .. "," .. a.y .. ">"
end

setmetatable(Vect, {
	__call = function (class, ...)
		return class._const(...)
	end,
})

function Vect._const(x, y)
	local self = setmetatable({}, Vect)

	self.x = x or 0
	self.y = y or 0

	return self
end

function Vect:length()
	return math.sqrt(self.x*self.x + self.y*self.y)
end

function Vect:dot(v)
	return self.x * v.x + self.y * v.y
end

function Vect:unit()
	return self / self:length()
end

function Vect:projOnto(v)
	return v * self:dot(v:unit())
end

function Vect:rhNormal()
	return Vect(-self.y, self.x)
end

function Vect:reflectOver(v)
	return self:projOnto(v) - self:projOnto(v:rhNormal())
end

return Vect
