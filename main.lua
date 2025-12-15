require "src.globals"

require "src.Player"
require "src.Terrain"

local player = Player:new(WIDTH / 2, HEIGHT / 2)
local terrain = Terrain:new()

function love.load()
    love.window.setTitle("River raid")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0.160, 0.678, 1)

    love.keyboard.keypressed = {}
    love.graphics.setLineWidth(1)
end

function love.update(dt)
    player:update(dt)
    terrain:update()

    love.keyboard.keypressed = {}
end

function love.draw()
    love.graphics.scale(SCREEN_SCALE)

    terrain:draw()
    player:draw()
end

function love.keyboard.waspressed(key)
    return love.keyboard.keypressed[key]
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    love.keyboard.keypressed[key] = true
end
