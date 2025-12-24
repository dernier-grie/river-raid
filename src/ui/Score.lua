Score = {}

local function format(n)
    return string.format("%0" .. SCORE_LENGTH .. "d", n)
end

function Score:new(x, y)
    local value = 0
    local _x = x or 0
    local _y = y or 0
    local valueString = format(value)
    local letters = {}
    for i = 1, #valueString do
        table.insert(letters, {
            string.sub(valueString, i, i),
            _x + (DIGIT_WIDTH + SCORE_LETTER_SPACING) * (i - 1)
        })
    end

    local this = {
        ["value"] = value,
        ["y"] = _y,
        ["letters"] = letters,
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Score:set(value)
    local valueString = format(value)
    for i = 1, #valueString do
        self.letters[i][1] = string.sub(valueString, i, i)
    end
    self.value = value
end

function Score:increment()
    self:set(self.value + 1)
end

function Score:draw()
    love.graphics.setColor(1, 1, 1)
    for _, letter in pairs(self.letters) do
        love.graphics.draw(Texture, Quads.digits[letter[1]], letter[2], self.y)
    end
end

return Score
