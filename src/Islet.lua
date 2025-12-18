Islet = {}

local ISLET_DEPTH_MAX = 8

local function getSegments(x1, x2)
    local segments = {}
    local x = x1
    local length = 1
    while x < x2 + length do
        length = math.random(3, 5)
        table.insert(segments, { x, x + length })
        x = x + length + math.random(2, 3)
    end

    local xOffset = (segments[#segments][2] - x2) / 2
    for i = 1, #segments do
        segments[i] = { segments[i][1] - xOffset, segments[i][2] - xOffset }
    end

    return segments
end

function Islet:new(x, y, width, height)
    local depth = math.floor(math.min(ISLET_DEPTH_MAX, height / 8))
    local this = {
        ["x"] = x,
        ["y"] = y,
        ["width"] = width,
        ["height"] = height,
        ["heightDepth"] = height - depth,
        ["x1"] = x - 0.5,
        ["x2"] = x + width + 0.5,
        ["y1"] = y - 0.5,
        ["y2"] = y + height - depth,
        ["y3"] = y + height + 0.5,
        ["y4"] = y + height + math.floor(depth / 2),
        ["segments"] = getSegments(x, x + width)
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Islet:draw()
    love.graphics.setColor(0.384, 0.333, 0.396)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(0.196, 0.2, 0.325)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.heightDepth)
    love.graphics.setColor(0.180, 0.133, 0.184)
    love.graphics.line(self.x1, self.y2, self.x2, self.y2)
    love.graphics.line(self.x1, self.y1, self.x1, self.y3, self.x2, self.y3, self.x2, self.y1, self.x1, self.y1)
    love.graphics.setColor(1, 1, 1)
    for _, segment in pairs(self.segments) do
        love.graphics.line(segment[1], self.y4, segment[2], self.y4)
    end
end
