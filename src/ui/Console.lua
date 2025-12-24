Console = {}

local paddingVertical = 3
local boxWidth, boxHeight = (DIGIT_WIDTH + SCORE_LETTER_SPACING) * SCORE_LENGTH - SCORE_LETTER_SPACING + 3, ICON_SIZE
local highlightNumber = 3
local highlightWidth = (boxWidth + 2 + ICON_SIZE) * highlightNumber
local highlightWhitespace = (WIDTH - highlightWidth) / highlightNumber
local backgroundHeight = ICON_SIZE + paddingVertical * 2

local progressCounter = 4
local progressInsetX, progressInsetY = 2, 2.5
local progressGap = 1
local progressWidth = ((boxWidth - progressInsetX * 2 + 1 - progressGap * (progressCounter - 1)) / progressCounter)
local progressHeight = boxHeight - progressInsetY * 2
local progressStep = progressWidth + progressGap

function Console:new()
    local icons = {
        { "bullet", math.floor(highlightWhitespace / 2),                                                    paddingVertical },
        { "score",  math.floor(highlightWhitespace / 2) + ICON_SIZE + boxWidth + highlightWhitespace,       paddingVertical },
        { "fuel",   math.floor(highlightWhitespace / 2) + (ICON_SIZE + boxWidth + highlightWhitespace) * 2, paddingVertical },
    }

    local boxes = {
        UI.LineBox:new(icons[1][2] + ICON_SIZE - 0.5, icons[1][3], boxWidth + 1.5, boxHeight),
        UI.LineBox:new(icons[2][2] + ICON_SIZE - 0.5, icons[2][3], boxWidth + 1.5, boxHeight),
        UI.LineBox:new(icons[3][2] + ICON_SIZE - 0.5, icons[3][3], boxWidth + 1.5, boxHeight),
    }

    local bullets = {
        ["x"] = boxes[1].x + progressInsetX,
        ["y"] = boxes[1].y + progressInsetY,
        ["counter"] = progressCounter,
        ["counterStart"] = progressCounter,
        ["t"] = 0,
        ["timeRecharge"] = 2
    }

    local fuel = {
        ["x"] = boxes[3].x + progressInsetX,
        ["y"] = boxes[3].y + progressInsetY,
        ["counter"] = progressCounter,
        ["counterStart"] = progressCounter,
        ["t"] = 0,
        ["timeExhaust"] = 60,
    }

    local fuelProgress = {
        ["x"] = boxes[3].x + boxWidth - 1,
        ["x1"] = boxes[3].x + 1,
        ["x2"] = boxes[3].x + boxWidth - 1,
        ["y"] = boxes[3].y,
    }

    local score = UI.Score:new(boxes[2].x + 2, boxes[2].y + 2)
    local scoreTimer = { 0, 0.01 } -- delay increment

    local this = {
        ["icons"] = icons,
        ["boxes"] = boxes,
        ["bullets"] = bullets,
        ["score"] = score,
        ["scoreTimer"] = scoreTimer,
        ["fuel"] = fuel,
        ["fuelProgress"] = fuelProgress,
        ["outOfFuel"] = false
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Console:canFire()
    return self.bullets.counter > 0
end

function Console:fire()
    self.bullets.counter = self.bullets.counter - 1
    self.bullets.t = 0
end

function Console:outOfFuel()
    return self.fuel.counter == 0
end

function Console:update(dt)
    self.scoreTimer[1] = self.scoreTimer[1] + dt
    if self.scoreTimer[1] > self.scoreTimer[2] then
        self.scoreTimer[1] = self.scoreTimer[1] % self.scoreTimer[2]
        self.score:increment()
    end

    if self.bullets.counter < self.bullets.counterStart then
        self.bullets.t = self.bullets.t + dt
        if self.bullets.t > self.bullets.timeRecharge then
            self.bullets.t = self.bullets.t % self.bullets.timeRecharge
            self.bullets.counter = math.min(self.bullets.counterStart, self.bullets.counter + 1)
        end
    end

    if self.fuel.counter > 0 then
        self.fuel.t = self.fuel.t + dt
        self.fuel.counter = math.floor((1 - (self.fuel.t / self.fuel.timeExhaust)) * self.fuel.counterStart) + 1

        self.fuelProgress.x = self.fuelProgress.x1 +
            math.ceil((self.fuelProgress.x2 - self.fuelProgress.x1) * (1 - self.fuel.t / self.fuel.timeExhaust))

        if self.fuel.counter == 0 then
            self.outOfFuel = true
        end
    end
end

function Console:draw()
    love.graphics.setColor(0.180, 0.133, 0.184)
    love.graphics.rectangle("fill", 0, 0, WIDTH, backgroundHeight)

    love.graphics.setColor(0.243, 0.208, 0.274)
    for i = 0, self.bullets.counterStart - 1 do
        love.graphics.rectangle("fill", self.bullets.x + i * progressStep,
            self.bullets.y,
            progressWidth, progressHeight)
    end

    for i = 0, self.fuel.counterStart - 1 do
        love.graphics.rectangle("fill", self.fuel.x + i * progressStep,
            self.fuel.y,
            progressWidth, progressHeight)
    end

    love.graphics.setColor(0.607, 0.670, 0.698)
    for i = 0, self.bullets.counter - 1 do
        love.graphics.rectangle("fill", self.bullets.x + i * progressStep,
            self.bullets.y,
            progressWidth, progressHeight)
    end

    for i = 0, self.fuel.counter - 1 do
        love.graphics.rectangle("fill", self.fuel.x + i * progressStep,
            self.fuel.y,
            progressWidth, progressHeight)
    end

    love.graphics.setColor(1, 1, 1)
    for _, icon in pairs(self.icons) do
        love.graphics.draw(Texture, Quads.console[icon[1]], icon[2], icon[3])
    end

    for _, box in pairs(self.boxes) do
        box:draw()
    end
    love.graphics.draw(Texture, Quads.console.fuelProgress, self.fuelProgress.x, self.fuelProgress.y)

    self.score:draw()
end

return Console:new()
