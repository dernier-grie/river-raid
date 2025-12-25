Flier = {}

local FLIERS_DIMENSIONS = {
    ["plane"] = { 14, 18 },
    ["planeSmall"] = { 12, 16 },
}

local FLIERS_SPEED = {
    ["plane"] = 15,
    ["planeSmall"] = 25
}


function Flier:new(x, y, type)
    local dimensions = FLIERS_DIMENSIONS[type]

    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = dimensions[1],
        ["height"] = dimensions[2],
        ["type"] = type,
        ["speed"] = FLIERS_SPEED[type],
        ["direction"] = 1,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Flier:update(dt)
    self.x = self.x + self.speed * self.direction * dt
end

function Flier:flip()
    self.direction = self.direction * -1
    self.x = self.x + self.direction
end

function Flier:draw()
    local scaleX = self.direction == -1 and -1 or 1
    local offsetX = self.direction == -1 and self.width or 0
    love.graphics.draw(Texture, Quads.fliers[self.type], self.x + offsetX, self.y, 0, scaleX, 1)
end

return Flier
