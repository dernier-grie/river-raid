PlayState = BaseState:new()

function PlayState:new(terrain)
    local player = Player:new(WIDTH / 2, HEIGHT - PLANE_HEIGHT)
    local _terrain = terrain or Terrain:new()
    local ui = UI:new()

    local this = {
        ["player"] = player,
        ["terrain"] = _terrain,
        ["ui"] = ui,
        ["bullets"] = {}
    }

    self.__index = self
    setmetatable(this, self)

    return this
end

function PlayState:update(dt)
    self.player:update(dt)
    if self.player.dx ~= 0 then
        local width = self.player.width -
            (self.player["banking"]) * math.abs(self.player["quadsIndex"] - self.player["quadsIndexStart"]) /
            self.player["quadsIndexGap"]
        local shouldCrash = self.terrain:intersects({
            x = self.player.x - width / 2,
            y = self.player.y,
            width = width,
            height = self.player.height,
        })
        if shouldCrash then
            GStateStack:push(BaseState:new()) -- actual gameover
        end
    end

    for k = #self.bullets, 1, -1 do
        self.bullets[k]:update(dt)
        if self.bullets[k].outOfBounds then
            table.remove(self.bullets, k)
        end
    end

    if love.keyboard.waspressed("space") then
        if self.ui.bullets.counter > 0 then
            self.ui.bullets.counter = self.ui.bullets.counter - 1
            local x1, x2 = self.player:fireCoords()
            table.insert(self.bullets, Bullet:new(x1, self.player.y - self.player.height / 2, -1))
            table.insert(self.bullets, Bullet:new(x2, self.player.y - self.player.height / 2, -1))
        end
    end
end

function PlayState:draw()
    self.terrain:draw()
    self.player:draw()
    for _, bullet in pairs(self.bullets) do
        bullet:draw()
    end
    self.ui:draw()
end
