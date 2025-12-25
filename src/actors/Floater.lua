Floater = {}

local FLOATERS_DIMENSIONS = {
    ["platform"] = { 16, 16 },
    ["boat"] = { 23, 13 },
}

function Floater:new(x, y, type)
    local dimensions = FLOATERS_DIMENSIONS[type]

    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = dimensions[1],
        ["height"] = dimensions[2],
        ["type"] = type
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Floater:draw()
    love.graphics.draw(Texture, Quads.floaters[self.type], self.x, self.y)
end

return Floater
