Flier = {}

local FLIERS_DIMENSIONS = {
    ["plane"] = { 14, 18 },
    ["planeSmall"] = { 12, 16 },
}

function Flier:new(x, y, type)
    local dimensions = FLIERS_DIMENSIONS[type]
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = dimensions[1],
        ["height"] = dimensions[2],
        ["type"] = type,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Flier:draw()
    love.graphics.draw(Texture, Quads.fliers[self.type], self.x, self.y)
end
