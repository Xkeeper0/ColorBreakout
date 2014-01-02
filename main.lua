--[[
Some weird game based on Breakout and Diamonds.

Made by a floof!
With some code by Yukita Mayako
]]
require 'lib/util'
local Constants = require('lib/const')
local Vect = require('lib/vector2')
local GameBoard = require('game/gameboard')

-- Program data.
local main = {
	game = 'Brickles Plus Plus',
	version = '0.0.0',
    --debug = true,

    -- Actual resolution settings.
	width = 800,
	height = 600,
	fullscreen = false,

	minWidth = 240,
	minHeight = 160,
	offx = 0,
	offy = 0,
	scale = 1,
}
package.loaded.main = main -- makes require('main') get this global settings table back.

function main.createBoard()
	main.gameBoard = GameBoard()
end

function main.initBoard()
	main.gameBoard:newBall(nil,nil,nil,Vect(math.random() * 32 - 16, math.random() * 32 - 16),nil,Constants.COLOR_YELLOW)
	main.gameBoard:newBall(nil,nil,nil,Vect(math.random() * 32 - 16, math.random() * 32 - 16),nil,Constants.COLOR_GREEN)
	main.gameBoard:newBall(nil,nil,nil,Vect(math.random() * 32 - 16, math.random() * 32 - 16),nil,Constants.COLOR_MAGENTA)
	
	main.gameBoard:newBrick({400, 20}, {400, 40}, {600, 40}, {600, 20})
	main.gameBoard:newBrick({100, 100}, {300, 100}, {200, 200})
end



function love.load()
	-- Putting everything here since this is just a test.
	love.window.setCaption("Test")
	love.graphics.setBackgroundColor(0x00, 0x00, 0x00, 0xFF)
	math.randomseed(os.time())
	for i=1,100 do math.random() end

	main.createBoard()
	main.initBoard()
end

function love.update(dt)
	-- For now, just update the board
	main.gameBoard:update(dt)
end

function love.draw()
	main.gameBoard:draw()
end

function love.run()
	-- Default from Löve wiki
	
	math.randomseed(os.time())
	for i=1,100 do math.random() end

	if love.load then love.load(arg) end

	local dt = 0

	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for e,a,b,c,d in love.event.poll() do
				if e == "quit" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				end
				love.handlers[e](a,b,c,d)
			end
		end

		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end

		-- Call update and draw
		if love.graphics then
			love.graphics.clear()
			if love.draw then love.draw() end
		end
		
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
		
		if love.graphics then love.graphics.present() end
		if love.timer then love.timer.sleep(0.001) end

	end

end
