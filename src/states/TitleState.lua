TitleState = States.Base:new()

function TitleState:new()
    local terrain = Terrain:new()

    local this = {
        ["terrain"] = terrain,
        ["t"] = 0,
        ["threshold"] = 2,
        ["yOffsets"] = { 0, 0 },
        ["yOffsetsMax"] = { 1, 2 },
    }

    self.__index = self
    setmetatable(this, self)

    return this
end

function TitleState:update(dt)
    self.t = self.t + dt
    local offset = math.sin(self.t / self.threshold * math.pi * 2)
    self.yOffsets = { offset * self.yOffsetsMax[1], offset * self.yOffsetsMax[2] }
    if self.t > self.threshold then
        self.t = self.t % self.threshold
    end

    if love.keyboard.waspressed("space") then
        GStateStack:pop()
        GStateStack:push(
            States.Play:new(self.terrain)
        )
    end
end

function TitleState:draw()
    self.terrain:draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Texture, Quads.title.roughEdges, 49, 30)
    love.graphics.draw(Texture, Quads.title.shootWord, 63, 85 + self.yOffsets[2])
    love.graphics.draw(Texture, Quads.title.leftWord, 31, 85 + self.yOffsets[2])
    love.graphics.draw(Texture, Quads.title.rightWord, 100, 85 + self.yOffsets[2])
    love.graphics.draw(Texture, Quads.title.shootKey, 57, 95 + self.yOffsets[1])
    love.graphics.draw(Texture, Quads.title.leftKey, 30, 95 + self.yOffsets[1])
    love.graphics.draw(Texture, Quads.title.rightKey, 102, 95 + self.yOffsets[1])
end

return TitleState:new()
