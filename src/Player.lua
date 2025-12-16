Player = {}

function Player:new(x, y)
    local quads_index_start = math.ceil(#Quads.plane / 2)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = PLANE_WIDTH,
        ["height"] = PLANE_HEIGHT,
        ["banking"] = PLANE_WIDTH / 2,
        ["dx"] = 0,
        ["ddx"] = 3,
        ["speed"] = 150,
        ["quads_index_start"] = quads_index_start,
        ["quads_index"] = quads_index_start,
        ["quads_index_gap"] = math.floor(#Quads.plane / 2),
    }

    self.__index = self
    setmetatable(this, self)
    return this
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
    self.quads_index = self.quads_index_start + math.ceil(self.dx * self.quads_index_gap)
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Texture, Quads.plane[self.quads_index], self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
end
