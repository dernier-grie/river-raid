Terrain = {}

local X_MIN = WIDTH / 10
local X_MAX = WIDTH * 9 / 10
local TERRAIN_RESOLUTION = 4

local debugPointCounter = math.floor(PLANE_HEIGHT / TERRAIN_RESOLUTION)

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
        ["debugPointIndex"] = 1
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Terrain:update(dt)
    if love.keyboard.waspressed("up") then
        self.debugPointIndex = math.max(1, self.debugPointIndex - 2)
    elseif love.keyboard.waspressed("down") then
        self.debugPointIndex = math.min(#self.pointsLeft - 1, self.debugPointIndex + 2)
    end
end

function Terrain:draw()
    love.graphics.setColor(0, 0.529, 0.317)
    love.graphics.polygon("fill", self.pointsLeft)
    love.graphics.polygon("fill", self.pointsRight)
    love.graphics.setColor(0.113, 0.168, 0.325)
    love.graphics.line(self.pointsLeft)
    love.graphics.line(self.pointsRight)

    love.graphics.setColor(0, 1, 0)
    for i = 0, debugPointCounter do
        love.graphics.circle(
            "fill",
            self.pointsLeft[self.debugPointIndex + 2 * i],
            self.pointsLeft[self.debugPointIndex + 1 + 2 * i],
            1)
        love.graphics.circle(
            "fill",
            self.pointsRight[self.debugPointIndex + 2 * i],
            self.pointsRight[self.debugPointIndex + 1 + 2 * i],
            1)
    end
end
