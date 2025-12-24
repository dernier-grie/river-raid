Floater = {}
setmetatable(Floater, { __index = QuadRect })

local FLOATERS_DIMENSIONS = {
    ["platform"] = { 16, 16 },
    ["boat"] = { 23, 13 },
}

function Floater:new(x, y, type)
    local dimensions = FLOATERS_DIMENSIONS[type]
    local this = QuadRect.new(self, x, y, dimensions[1], dimensions[2], Quads.floaters[type])

    self.__index = self
    setmetatable(this, self)
    return this
end
