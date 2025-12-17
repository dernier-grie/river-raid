Terrain = {}

local X_MIN = WIDTH / 10
local X_MAX = WIDTH * 9 / 10
local TERRAIN_RESOLUTION = 4

function Terrain:new()
    local x1, x2 = X_MIN, X_MAX
    local pointsLeft = { 0, -1, x1, -1 }
    local pointsRight = { WIDTH, -1, x2, -1 }
    for i = 0, math.ceil(HEIGHT / TERRAIN_RESOLUTION) do
        table.insert(pointsLeft, x1)
        table.insert(pointsLeft, i * TERRAIN_RESOLUTION)
        table.insert(pointsRight, x2)
        table.insert(pointsRight, i * TERRAIN_RESOLUTION)
    end
    table.insert(pointsLeft, x1)
    table.insert(pointsLeft, HEIGHT + 1)
    table.insert(pointsLeft, 0)
    table.insert(pointsLeft, HEIGHT + 1)
    table.insert(pointsRight, x2)
    table.insert(pointsRight, HEIGHT + 1)
    table.insert(pointsRight, WIDTH)
    table.insert(pointsRight, HEIGHT + 1)

    local this = {
        ["pointsLeft"] = pointsLeft,
        ["pointsRight"] = pointsRight,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Terrain:intersects(rect)
    local y = rect.y
    local index = math.ceil(y / TERRAIN_RESOLUTION) * 2 + 1 + 4
    local indexCounter = math.floor(rect.height / TERRAIN_RESOLUTION)

    local _intersects = false
    for i = 0, indexCounter do
        local lx = self.pointsLeft[index + (i * 2)]
        local rx = self.pointsRight[index + (i * 2)]
        if rect.x <= lx or rect.x + rect.width >= rx then
            _intersects = true
            break
        end
    end

    return _intersects
end

function Terrain:draw()
    love.graphics.setColor(0.196, 0.2, 0.325)
    love.graphics.polygon("fill", self.pointsLeft)
    love.graphics.polygon("fill", self.pointsRight)
    love.graphics.setColor(0.180, 0.133, 0.184)
    love.graphics.line(self.pointsLeft)
    love.graphics.line(self.pointsRight)
end
