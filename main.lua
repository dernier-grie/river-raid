require "src.Dependencies"

function love.load()
    love.window.setTitle("River raid")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0.302, 0.608, 0.902)
    love.graphics.setLineWidth(LINE_WIDTH)

    GStateStack = StateStack:new(
        {
            PlayState:new() -- TitleState:new()
        }
    )
    love.keyboard.keypressed = {}
end

function love.update(dt)
    GStateStack:update(dt)

    love.keyboard.keypressed = {}
end

function love.draw()
    love.graphics.scale(SCREEN_SCALE)
    GStateStack:draw()
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
