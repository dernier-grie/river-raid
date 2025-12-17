Bridge = {}

local BRIDGE_DIMENSIONS = { 2, 17 }

function Bridge:new(x1, x2, y)
    local segmentWidth, segmentHeight = BRIDGE_DIMENSIONS[1], BRIDGE_DIMENSIONS[2]
    local gap = x2 - x1
    local segments = math.floor(gap / segmentWidth) + 1
    if segments % 2 ~= 0 then
        segments = segments + 1
    end
    local width = segments * segmentWidth
    local x = x1 - math.floor(width - gap) / 2
    local sprites = {
        { "q1", x },

    }
    for i = 1, math.floor((segments - 2) / 2) do
        table.insert(sprites, { "q2", x + segmentWidth * (i - 0.5) * 2 })
        table.insert(sprites, { "q3", x + segmentWidth * (i) * 2 })
    end
    table.insert(sprites, { "q4", x + width - segmentWidth })

    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = width,
        ["height"] = segmentHeight,
        ["sprites"] = sprites
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Bridge:draw()
    for _, sprite in pairs(self.sprites) do
        love.graphics.draw(Texture, Quads.bridge[sprite[1]], sprite[2], self.y)
    end
end
