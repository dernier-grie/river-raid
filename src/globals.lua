WIDTH, HEIGHT = 176, 160
SCREEN_SCALE = 3
SCREEN_WIDTH, SCREEN_HEIGHT = WIDTH * SCREEN_SCALE, HEIGHT * SCREEN_SCALE

love.graphics.setDefaultFilter("nearest", "nearest")
Texture = love.graphics.newImage("/graphics/spritesheet.png")
Quads = {}

Quads.plane = {}

PLANE_WIDTH = 24
PLANE_HEIGHT = 16

for i = 0, 8 do
    table.insert(Quads.plane, love.graphics.newQuad(
        i * PLANE_WIDTH,
        0,
        PLANE_WIDTH,
        PLANE_HEIGHT,
        Texture
    ))
end
