UI = {}

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

function UI:new()
    local icons = {
        { "bullet", math.floor(highlightWhitespace / 2),                                                    paddingVertical },
        { "score",  math.floor(highlightWhitespace / 2) + ICON_SIZE + boxWidth + highlightWhitespace,       paddingVertical },
        { "fuel",   math.floor(highlightWhitespace / 2) + (ICON_SIZE + boxWidth + highlightWhitespace) * 2, paddingVertical },
    }

    local boxes = {
        Box:new(icons[1][2] + ICON_SIZE, icons[1][3], boxWidth, boxHeight),
        Box:new(icons[2][2] + ICON_SIZE, icons[2][3], boxWidth, boxHeight),
        Box:new(icons[3][2] + ICON_SIZE, icons[3][3], boxWidth, boxHeight),
    }

    local bullets = {
        ["x"] = boxes[1].x1 + progressInsetX,
        ["y"] = boxes[1].y1 + progressInsetY,
        ["counter"] = progressCounter
    }

    local fuel = {
        ["x"] = boxes[3].x1 + progressInsetX,
        ["y"] = boxes[3].y1 + progressInsetY,
        ["counter"] = progressCounter
    }

    local score = Score:new(boxes[2].x1 + 2, boxes[2].y1 + 2)

    local this = {
        ["icons"] = icons,
        ["boxes"] = boxes,
        ["bullets"] = bullets,
        ["score"] = score,
        ["fuel"] = fuel,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function UI:draw()
    love.graphics.setColor(0.180, 0.133, 0.184)
    love.graphics.rectangle("fill", 0, 0, WIDTH, backgroundHeight)

    love.graphics.setColor(1, 1, 1)
    for _, icon in pairs(self.icons) do
        love.graphics.draw(Texture, Quads.UI[icon[1]], icon[2], icon[3])
    end

    for _, box in pairs(self.boxes) do
        box:draw()
    end

    love.graphics.setColor(0.607, 0.670, 0.698)
    for i = 0, self.bullets.counter - 1 do
        love.graphics.rectangle("fill", self.bullets.x + i * progressStep,
            self.bullets.y,
            progressWidth, progressHeight)
    end

    self.score:draw()

    for i = 0, self.fuel.counter - 1 do
        love.graphics.rectangle("fill", self.fuel.x + i * progressStep,
            self.fuel.y,
            progressWidth, progressHeight)
    end
end
