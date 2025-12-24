QuadRect = {}

function QuadRect:new(x, y, width, height, quad)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = width,
        ["height"] = height,
        ["quad"] = quad,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function QuadRect:draw()
    love.graphics.draw(Texture, self.quad, self.x, self.y)
end

return QuadRect
