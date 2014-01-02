--[[
Ball object and methods.
]]

local Constants = require('/lib/const')
local Vect = require('/lib/vector2')

local Ball = {}
Ball.__index = Ball

setmetatable(Ball, {
	__call = function (class, ...)
		return class._const(...)
	end,
})

function Ball._const(x, y, radius, vel, rot, color)
	local self = setmetatable({}, Ball)
	self.x = x or 400
	self.y = y or 300
	self.radius = radius or 4
	self.vel = vel or Vect(10, -10)
	self.rot = rot or 0
	self.color = color or Constants.COLOR_WHITE
	self.coll = 0
	return self
end

function Ball:draw()
	if love.graphics then 
		love.graphics.setColor(self.color)
		love.graphics.circle("fill", self.x, self.y, self.radius, 64)
	end
end

function Ball:update(dt)
	self.x = self.x + self.vel.x * (dt / Constants.STEP)
	self.y = self.y + self.vel.y * (dt / Constants.STEP)
	
	if (self.x + self.radius > love.window.getWidth()) or (self.x - self.radius < 0) then
		self.coll = self.coll + 1
		self.vel = self.vel:reflectOver(Vect(0,1))
		if (self.x + self.radius > love.window.getWidth()) then self.x = love.window.getWidth() - (self.x + self.radius - love.window.getWidth()) - self.radius
		elseif (self.x - self.radius < 0) then self.x = -(self.x - self.radius) + self.radius
		end
		local bip = love.audio.newSource("/snd/bip.wav")
		love.audio.play(bip)
	end
	
	if (self.y + self.radius > love.window.getHeight()) or (self.y - self.radius < 0) then
		self.coll = self.coll + 1
		self.vel = self.vel:reflectOver(Vect(1,0))
		if (self.y + self.radius > love.window.getHeight()) then self.y = love.window.getHeight() - (self.y + self.radius - love.window.getHeight()) - self.radius
		elseif (self.y - self.radius < 0) then self.y = -(self.y - self.radius) + self.radius
		end
		local bip = love.audio.newSource("/snd/bip.wav")
		love.audio.play(bip)
	end
end

return Ball