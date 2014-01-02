--[[
	Game state handler.
]]

local constants = require('/lib/const')
local Vect = require('lib/vector2')

local Ball = require('obj/ball')
local Brick = require('obj/brick')

local GameBoard = {}
GameBoard.__index = GameBoard

setmetatable(GameBoard, {
	__call = function (class, ...)
		return class._const(...)
	end,
})

function GameBoard._const()
	local self = setmetatable({}, GameBoard)
	self.dtimer = 0

	self.balls = {}
	self.bricks = {}

	return self
end

function GameBoard:newBall(...)
	table.insert(self.balls, Ball(...))
end

function GameBoard:removeBall(n)
	table.remove(self.balls, n)
end

function GameBoard:newBrick(...)
	table.insert(self.bricks, Brick(...))
end

function GameBoard:removeBrick(n)
	table.remove(self.bricks, n)
end

function GameBoard:update(dt)
	for k,v in pairs(self.bricks) do
		local f = v.update
		local e,err = pcall(f,v,dt)
		if (not e) then
			print(err)
		end
		--self.bricks[k]:update(dt)
	end
	for k,v in pairs(self.balls) do
		local f = v.update
		local e,err = pcall(f,v,dt)
		if (not e) then
			print(err)
		end
		love.graphics.setColor(v.color)
		love.graphics.print(v.coll, 20, 20+16*k)
		--balls[k]:update(dt)
	end
end

function GameBoard:draw()
	for k,v in pairs(self.bricks) do
		v:draw()
	end
	for k,v in pairs(self.balls) do
		v:draw()
	end
end

return GameBoard