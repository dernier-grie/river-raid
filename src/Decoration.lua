Decoration = {}
setmetatable(Decoration, { __index = QuadRect })

local DECORATIONS_DIMENSIONS = {
    ["tree"] = { 12, 14 },
    ["treeSmall"] = { 11, 13 },
    ["house"] = { 16, 11 },
    ["lighthouse"] = { 11, 11 },
}

function Decoration:new(x, y, type)
    local dimensions = DECORATIONS_DIMENSIONS[type]
    local this = QuadRect.new(self, x, y, dimensions[1], dimensions[2], Quads.decorations[type])

    self.__index = self
    setmetatable(this, self)
    return this
end
