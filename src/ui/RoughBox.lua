RoughBox = {}

local INSET_BOTTOM_RIGHT = 2

function RoughBox:new(x, y, width, height)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = width,
        ["height"] = height,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function RoughBox:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height - INSET_BOTTOM_RIGHT)
    love.graphics.rectangle("fill", self.x, self.y, self.width - INSET_BOTTOM_RIGHT, self.height)
end

return RoughBox
