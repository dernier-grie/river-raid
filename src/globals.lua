WIDTH, HEIGHT = 144, 128
SCREEN_SCALE = 4
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
BULLET_WIDTH, BULLET_HEIGHT = 6, 7

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
    love.graphics.newQuad(32, 22, 6, 7, Texture),
    love.graphics.newQuad(38, 22, 6, 7, Texture),
}

Quads.console = {
    ["bullet"] = love.graphics.newQuad(0, 22, 9, 9, Texture),
    ["score"] = love.graphics.newQuad(9, 22, 9, 9, Texture),
    ["fuel"] = love.graphics.newQuad(18, 22, 9, 9, Texture),
    ["fuelProgress"] = love.graphics.newQuad(27, 22, 1, 9, Texture),
}

Quads.title = {
    ["roughEdges"] = love.graphics.newQuad(44, 16, 45, 13, Texture),
    ["leftWord"] = love.graphics.newQuad(89, 16, 14, 7, Texture),
    ["rightWord"] = love.graphics.newQuad(103, 16, 16, 7, Texture),
    ["shootWord"] = love.graphics.newQuad(119, 16, 18, 7, Texture),
    ["leftKey"] = love.graphics.newQuad(89, 23, 11, 9, Texture),
    ["rightKey"] = love.graphics.newQuad(100, 23, 11, 9, Texture),
    ["shootKey"] = love.graphics.newQuad(111, 23, 30, 9, Texture),
}

Quads.pickups = {
    ["fuel"] = love.graphics.newQuad(26, 31, 9, 10, Texture)
}

Quads.explosion = {}
for i = 0, 4 do
    table.insert(Quads.explosion, love.graphics.newQuad(100 + 12 * i, 32, 12, 12, Texture))
end

Quads.bridge = {
    ["q1"] = love.graphics.newQuad(17, 31, 2, 17, Texture),
    ["q2"] = love.graphics.newQuad(19, 31, 2, 17, Texture),
    ["q3"] = love.graphics.newQuad(21, 31, 2, 17, Texture),
    ["q4"] = love.graphics.newQuad(23, 31, 2, 17, Texture),
}


Quads.floaters = {
    ["platform"] = love.graphics.newQuad(61, 31, 16, 16, Texture),
    ["boat"] = love.graphics.newQuad(77, 34, 23, 13, Texture),
}

Quads.fliers = {
    ["plane"] = love.graphics.newQuad(35, 30, 14, 18, Texture),
    ["planeSmall"] = love.graphics.newQuad(48, 31, 12, 16, Texture)
}

Quads.decorations = {
    ["tree"] = love.graphics.newQuad(162, 34, 12, 14, Texture),
    ["treeSmall"] = love.graphics.newQuad(174, 35, 11, 13, Texture),
    ["house"] = love.graphics.newQuad(185, 37, 16, 11, Texture),
    ["lighthouse"] = love.graphics.newQuad(201, 37, 11, 11, Texture),
}
