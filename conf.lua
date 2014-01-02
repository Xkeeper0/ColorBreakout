--[[
	Love2D config.
]]

function love.conf(t)
	local cfg = {
		title = 'Brickles Plus Plus',
		author = 'Raspberryfloof',
		url = '',
		identity = nil, -- AppData folder
		version = '0.8.0', -- Love2D version
		console = false, -- Windows command prompt output
		release = false,
		screen = {
			width=800,
			height=640,
			fullscreen=false,
			vsync=true,
			fsaa=0
		},
		modules = {
			mouse=false, -- Mouse clicking inputs.
			physics=false -- ADVANCED 2D physics engine.
		}
	}

	for k,v in pairs(cfg) do
		if type(v) == "table" then
			for l,v in pairs(v) do
				t[k][l] = v
			end
		else
			t[k] = v
		end
	end
end
