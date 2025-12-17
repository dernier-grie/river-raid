Player = {}

function Player:new(x, y)
    local quadsIndexStart = math.ceil(#Quads.plane / 2)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = PLANE_WIDTH,
        ["height"] = PLANE_HEIGHT,
        ["banking"] = PLANE_WIDTH / 2,
        ["dx"] = 0,
        ["ddx"] = 3,
        ["speed"] = 150,
        ["quadsIndexStart"] = quadsIndexStart,
        ["quadsIndex"] = quadsIndexStart,
        ["quadsIndexGap"] = math.floor(#Quads.plane / 2),
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Player:getWidth()
    return self.width -
    (self["banking"]) * math.abs(self["quadsIndex"] - self["quadsIndexStart"]) / self["quadsIndexGap"]
end

function Player:getFireXs()
    local fireGap = PLANE_WIDTH / 6 +
        PLANE_WIDTH / 6 * (1 - math.abs(self.quadsIndex - self.quadsIndexStart) / self.quadsIndexGap)
    return self.x - fireGap, self.x + fireGap
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self.dx = math.max(-1, self.dx - self.ddx * dt)
    elseif love.keyboard.isDown("right") then
        self.dx = math.min(1, self.dx + self.ddx * dt)
    elseif self.dx ~= 0 then
        if self.dx < 0 then
            self.dx = math.min(0, self.dx + self.ddx / 2 * dt)
        else
            self.dx = math.max(0, self.dx - self.ddx / 2 * dt)
        end
    end

    self.x = self.x + self.dx * self.speed * dt
    self.quadsIndex = self.quadsIndexStart + math.ceil(self.dx * self.quadsIndexGap)
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Texture, Quads.plane[self.quadsIndex], self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end
