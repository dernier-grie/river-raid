require "src.globals"

function love.load()
    love.window.setTitle("River raid")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0.160, 0.678, 1)

    love.keyboard.keypressed = {}
end

function love.update(dt)
    -- update game
    love.keyboard.keypressed = {}
end

function love.draw()
    love.graphics.scale(SCREEN_SCALE)

    love.graphics.draw(Texture, Quads.plane[4], 0, 0)
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
