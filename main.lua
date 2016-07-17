debug = true
require "source.engine.Engine"
require "source.engine.Camera"
require "source.engine.Object"
require "source.engine.CollisionFunctions"
require "source.engine.Timer"
require "source.control_gameplay"
require "source.playground_button"

function love.load(arg)
	math.randomseed(os.clock())
	Game:createInstance("control_gameplay")
end

function love.keypressed(key)
	-- Run the onKeyPress() function in all objects
	Game:KeyPressed(key)
end

function love.keyreleased(key)
	-- Run the onKeyRelease() function in all objects
	Game:KeyReleased(key)
end

function love.mousepressed(x,y,button)
	-- Run the onMousePress() function in all objects
	Game:MousePressed(x,y,button)
end

function love.mousereleased(x,y,button)
	-- Run the onMouseRelease() function in all objects
	Game:MouseReleased(x,y,button)
end

function love.update(dt)
	-- Run the onUpdate() function for all objects
	Game:Update(dt)
end

function love.draw(dt)
	Camera:set()

	-- Draw all of the objects in the objectHandler, also run the onDrawBegin() and onDrawEnd() functions
	Game:Draw()

	Camera:unset()
end
