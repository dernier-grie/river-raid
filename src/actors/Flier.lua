Flier = {}
setmetatable(Flier, { __index = QuadRect })

local FLIERS_DIMENSIONS = {
    ["plane"] = { 14, 18 },
    ["planeSmall"] = { 12, 16 },
}

function Flier:new(x, y, type)
    local dimensions = FLIERS_DIMENSIONS[type]
    local this = Core.QuadRect.new(self, x, y, dimensions[1], dimensions[2], Quads.fliers[type])

    self.__index = self
    setmetatable(this, self)
    return this
end

return Flier
