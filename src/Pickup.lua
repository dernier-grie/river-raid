Pickup = {}

local PICKUP_WIDTH, PICKUP_HEIGHT = 9, 10

function Pickup:new(x, y)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = PICKUP_WIDTH,
        ["height"] = PICKUP_HEIGHT,
        ["t"] = 0,
        ["threshold"] = 2,
        ["yOffset"] = 0,
        ["yOffsetMax"] = 1,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Pickup:update(dt)
    self.t = self.t + dt
    self.yOffset = math.sin(self.t / self.threshold * math.pi * 2) * self.yOffsetMax
    if self.t > self.threshold then
        self.t = self.t % self.threshold
    end
end

function Pickup:draw()
    love.graphics.draw(Texture, Quads.pickups.fuel, self.x, self.y + self.yOffset)
end
