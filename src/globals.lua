WIDTH, HEIGHT = 144, 144
SCREEN_SCALE = 3
SCREEN_WIDTH, SCREEN_HEIGHT = WIDTH * SCREEN_SCALE, HEIGHT * SCREEN_SCALE

love.graphics.setDefaultFilter("nearest", "nearest")
Texture = love.graphics.newImage("/graphics/spritesheet.png")
Quads = {}

Quads.plane = {}

LINE_WIDTH = 1
PLANE_WIDTH = 24
PLANE_HEIGHT = 16
DIGIT_WIDTH = 4
SCORE_LETTER_SPACING = 1
SCORE_LENGTH = 5
ICON_SIZE = 9

for i = 0, 8 do
    table.insert(Quads.plane, love.graphics.newQuad(
        i * PLANE_WIDTH,
        0,
        PLANE_WIDTH,
        PLANE_HEIGHT,
        Texture
    ))
end

Quads.digits = {}
for i = 0, 9 do
    Quads.digits[tostring(i)] = love.graphics.newQuad(i * DIGIT_WIDTH, 16, DIGIT_WIDTH, 5, Texture)
end

Quads.bullet = {
    love.graphics.newQuad(32, 22, 6, 8, Texture),
    love.graphics.newQuad(38, 22, 6, 8, Texture),
}

Quads.UI = {
    ["bullet"] = love.graphics.newQuad(0, 22, 9, 9, Texture),
    ["score"] = love.graphics.newQuad(9, 22, 9, 9, Texture),
    ["fuel"] = love.graphics.newQuad(18, 22, 9, 9, Texture),
    ["fuelProgress"] = love.graphics.newQuad(27, 22, 1, 9, Texture),
    ["boxStart"] = love.graphics.newQuad(28, 22, 2, 9, Texture),
    ["boxEnd"] = love.graphics.newQuad(30, 22, 2, 9, Texture),
}
