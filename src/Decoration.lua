Decoration = {}

local DECORATION_TYPES = { "tree", "treeSmall", "house", "lighthouse", }
local DECORATION_DIMENSIONS = {
    ["tree"] = { 12, 14 },
    ["treeSmall"] = { 11, 13 },
    ["house"] = { 16, 11 },
    ["lighthouse"] = { 11, 11 },
}

function Decoration:new(x, y, type)
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["type"] = type,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Decoration:draw()
    love.graphics.draw(Texture, Quads.decorations[self.type], self.x, self.y)
end
