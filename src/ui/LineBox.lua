LineBox = {}

-- assumes lineWidth 1
local INSET = 1

function LineBox:new(x, y, width, height)
    local x1, y1, x2, y2 = x, y, x + width, y + height
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = width,
        ["height"] = height,
        ["points"] = {
            x1 + (INSET + 0.5), y1 + 0.5, x2 - (INSET + 0.5), y1 + 0.5, x2 - (INSET + 0.5), y1 + (INSET + 0.5),
            x2 - 0.5, y1 + (INSET + 0.5), x2 - 0.5, y2 - (INSET + 0.5), x2 - (INSET + 0.5), y2 - (INSET + 0.5),
            x2 - (INSET + 0.5),
            y2 - 0.5, x1 + (INSET + 0.5), y2 - 0.5, x1 + (INSET + 0.5), y2 - (INSET + 0.5), x1 + 0.5, y2 -
        (INSET + 0.5),
            x1 + 0.5, y1 + (INSET + 0.5), x1 + (INSET + 0.5), y1 + (INSET + 0.5), x1 + (INSET + 0.5), y1 + 0.5
        }
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function LineBox:draw()
    love.graphics.line(self.points)
end

return LineBox
