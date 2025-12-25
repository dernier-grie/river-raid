Bullet = {}

local BULLET_SPEED = 180

function Bullet:new(x, y, dy)
    local this = {
        ["x"] = x - BULLET_WIDTH / 2,
        ["y"] = y - BULLET_HEIGHT / 2,
        ["width"] = BULLET_WIDTH,
        ["height"] = BULLET_HEIGHT,
        ["dy"] = dy or -1,
        ["speed"] = BULLET_SPEED,
        ["quadTimer"] = 0,
        ["quadIndex"] = 1,
        ["quadInterval"] = 0.2,
        ["outOfBounds"] = false
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self.quadTimer = self.quadTimer + dt
    if self.quadTimer > self.quadInterval then
        self.quadTimer = 0
        self.quadIndex = self.quadIndex == 1 and 2 or 1
    end
    self.y = self.y + self.dy * self.speed * dt

    if self.y < -BULLET_HEIGHT or self.y > HEIGHT then
        self.outOfBounds = true
    end
end

function Bullet:draw()
    love.graphics.draw(Texture, Quads.bullet[self.quadIndex], self.x, self.y)
end

return Bullet
