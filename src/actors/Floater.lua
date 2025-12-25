Floater = {}

local FLOATERS_DIMENSIONS = {
    ["platform"] = { 16, 16 },
    ["boat"] = { 23, 13 },
}


local FLOATERS_SPEED_RANGE = {
    ["platform"] = { 0, 0 },
    ["boat"] = { 2, 2 }
}

function Floater:new(x, y, type)
    local dimensions = FLOATERS_DIMENSIONS[type]

    local this = {
        ["xStart"] = x,
        ["x"] = x,
        ["y"] = y,
        ["width"] = dimensions[1],
        ["height"] = dimensions[2],
        ["type"] = type,
        ["t"] = 0,
        ["tau"] = math.pi * 2,
        ["speed"] = FLOATERS_SPEED_RANGE[type][1],
        ["range"] = FLOATERS_SPEED_RANGE[type][2]
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Floater:update(dt)
    self.t = (self.t + dt * self.speed) % self.tau
    self.x = self.xStart + math.sin(self.t) * self.range
end

function Floater:draw()
    love.graphics.draw(Texture, Quads.floaters[self.type], self.x, self.y)
end

return Floater
