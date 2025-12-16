TitleState = BaseState:new()

local titleX, titleY = math.floor(WIDTH / 2 - 22.5), 30
local wordsY = 80
local leftWordX = math.floor(WIDTH / 4) - 7
local rightWordX = math.floor(WIDTH * 3 / 4) - 8
local shootWordX = math.floor(WIDTH / 2) - 9
local keysY = wordsY + 10
local shootOffsetY = 2
local leftKeyX = math.floor(WIDTH / 4 - 5.5)
local rightKeyX = math.floor(WIDTH * 3 / 4 - 5.5)
local shootKeyX = math.floor(WIDTH / 2) - 15

function TitleState:new()
    local terrain = Terrain:new()

    local this = {
        ["terrain"] = terrain,
    }

    self.__index = self
    setmetatable(this, self)

    return this
end

function TitleState:update(dt)
    if love.keyboard.waspressed("space") then
        GStateStack:pop()
        GStateStack:push(
            PlayState:new(self.terrain)
        )
    end
end

function TitleState:draw()
    self.terrain:draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(Texture, Quads.title.roughEdges, titleX, titleY)
    love.graphics.draw(Texture, Quads.title.shootWord, shootWordX, wordsY + shootOffsetY)
    love.graphics.draw(Texture, Quads.title.leftWord, leftWordX, wordsY)
    love.graphics.draw(Texture, Quads.title.rightWord, rightWordX, wordsY)
    love.graphics.draw(Texture, Quads.title.shootKey, shootKeyX, keysY + shootOffsetY)
    love.graphics.draw(Texture, Quads.title.leftKey, leftKeyX, keysY)
    love.graphics.draw(Texture, Quads.title.rightKey, rightKeyX, keysY)
end
