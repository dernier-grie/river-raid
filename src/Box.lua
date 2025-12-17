Box = {}


function Box:new(x, y, width, height)
    local this = {
        ["x1"] = x,
        ["y1"] = y,
        ["x2"] = x + width,
        ["y2"] = y + height,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Box:draw()
    love.graphics.line(self.x1, self.y1 + 0.5, self.x2, self.y1 + 0.5)
    love.graphics.line(self.x1, self.y2 - 0.5, self.x2, self.y2 - 0.5)
    love.graphics.draw(Texture, Quads.console.boxStart, self.x1 - 1, self.y1)
    love.graphics.draw(Texture, Quads.console.boxEnd, self.x2, self.y1)
end
