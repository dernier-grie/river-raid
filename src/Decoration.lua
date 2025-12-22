Decoration = {}

local DECORATIONS_DIMENSIONS = {
    ["tree"] = { 12, 14 },
    ["treeSmall"] = { 11, 13 },
    ["house"] = { 16, 11 },
    ["lighthouse"] = { 11, 11 },
}

function Decoration:new(x, y, type)
    local dimensions = DECORATIONS_DIMENSIONS[type]
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = dimensions[1],
        ["height"] = dimensions[2],
        ["type"] = type,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Decoration:draw()
    love.graphics.draw(Texture, Quads.decorations[self.type], self.x, self.y)
end
