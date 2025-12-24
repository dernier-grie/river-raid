Explosion = {}

local EXPLOSION_SIZE = 12
local QUADS_NUMBER = #Quads.explosion

function Explosion:new(x, y, duration)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["size"] = EXPLOSION_SIZE,
        ["quadIndex"] = 1,
        ["quadsNumber"] = QUADS_NUMBER,
        ["t"] = 0,
        ["duration"] = duration or (0.09 * QUADS_NUMBER),
        ["outOfTime"] = false
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Explosion:update(dt)
    if not self.outOfTime then
        self.t = self.t + dt
        self.quadIndex = 1 + math.floor(self.t / self.duration * self.quadsNumber)
        if self.t > self.duration then
            self.outOfTime = true
        end
    end
end

function Explosion:draw()
    love.graphics.draw(Texture, Quads.explosion[self.quadIndex], self.x, self.y, 0, 1, 1, self.size / 2, self.size / 2)
end

return Explosion
