Floater = {}

local FLOATER_TYPES = { "platform", "boat" }
local FLIER_DIMENSIONS = {
    ["platform"] = { 16, 16 },
    ["boat"] = { 11, 13 },
}

function Floater:new(x, y, type)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["type"] = type,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Floater:draw()
    love.graphics.draw(Texture, Quads.floaters[self.type], self.x, self.y)
end
