PlayState = States.Base:new()

local function collides(rect1, rect2)
    if rect1.x + rect1.width < rect2.x or rect1.x > rect2.x + rect2.width or rect1.y + rect1.height < rect2.y or rect1.y > rect2.y + rect2.height then
        return false
    end
    return true
end

function PlayState:new(terrain)
    local player = Actors.Player:new(WIDTH / 2, HEIGHT - PLANE_HEIGHT)
    local _terrain = terrain or World.Terrain:new()
    local console = UI.Console:new()

    local this = {
        ["player"] = player,
        ["terrain"] = _terrain,
        ["console"] = console,
        ["bridges"] = {},
        ["bullets"] = {},
        ["explosions"] = {},
        ["pickups"] = {},
        ["fliers"] = {
            Flier:new(100, 20, "plane")
        },
        ["floaters"] = {
            Floater:new(40, player.y - player.height, "platform")
        },
        ["decorations"] = {},
    }

    self.__index = self
    setmetatable(this, self)

    return this
end

function PlayState:update(dt)
    self.player:update(dt)
    self.console:update(dt)

    local playerRect = {
        x = self.player.x - self.player.width / 2,
        y = self.player.y - self.player.height / 2,
        width = self.player.width,
        height = self.player.height,
    }

    if self.player.dx ~= 0 then
        local shouldCrash = self.terrain:intersects(playerRect)
        if shouldCrash then
            -- gameover
            self:explode(playerRect)
        end
    end

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
        if bullet.outOfBounds then
            table.remove(self.bullets, k)
        end
    end

    for kf, flier in pairs(self.fliers) do
        flier:update(dt)
        if self.terrain:intersects(flier) then
            flier:flip()
        end

        for kb, bullet in pairs(self.bullets) do
            if collides(bullet, flier) then
                table.remove(self.fliers, kf)
                table.remove(self.bullets, kb)
                self:explode(flier)
            end
        end

        if collides(playerRect, flier) then
            -- gameover
            table.remove(self.fliers, kf)
            self:explode(flier)
            self:explode(playerRect)
        end
    end

    for kf, floater in pairs(self.floaters) do
        floater:update(dt)

        for kb, bullet in pairs(self.bullets) do
            if collides(bullet, floater) then
                table.remove(self.floaters, kf)
                table.remove(self.bullets, kb)
                self:explode(floater)
            end
        end

        if collides(playerRect, floater) then
            -- gameover
            table.remove(self.floaters, kf)
            self:explode(floater)
            self:explode(playerRect)
        end
    end

    for _, pickup in pairs(self.pickups) do
        pickup:update(dt)
    end

    for k, explosion in pairs(self.explosions) do
        explosion:update(dt)
        if explosion.outOfTime then
            table.remove(self.explosions, k)
        end
    end

    if love.keyboard.waspressed("space") and self.console:canFire() then
        local x1, x2 = self.player:getFireXs()
        self.console:fire()
        table.insert(self.bullets, Actors.Bullet:new(x1, self.player.y - self.player.height / 2, -1))
        table.insert(self.bullets, Actors.Bullet:new(x2, self.player.y - self.player.height / 2, -1))
    end

    if self.console.outOfFuel then
        -- gameover
        GStateStack:push(States.Base:new())
    end
end

function PlayState:draw()
    self.terrain:draw()

    self.player:draw()

    love.graphics.setColor(1, 1, 1)
    for _, bullet in pairs(self.bullets) do
        bullet:draw()
    end

    for _, pickup in pairs(self.pickups) do
        pickup:draw()
    end


    for _, floater in pairs(self.floaters) do
        floater:draw()
    end

    for _, flier in pairs(self.fliers) do
        flier:draw()
    end

    for _, explosion in pairs(self.explosions) do
        explosion:draw()
    end

    for _, decoration in pairs(self.decorations) do
        decoration:draw()
    end

    for _, bridge in pairs(self.bridges) do
        bridge:draw()
    end

    self.console:draw()
end

function PlayState:explode(rect)
    local width, height = rect.width, rect.height
    local particles = { math.random(1, 2), math.random(1, 2) }
    for i = 0, particles[1] do
        local x = math.floor(rect.x + width / 2 + (math.random() - 0.5) * (width) / (particles[1]) * i)
        for j = 0, particles[2] do
            local y = math.floor(rect.y + height / 2 + (math.random() - 0.5) * (height) / (particles[2]) * j)
            table.insert(self.explosions, Explosion:new(x, y))
        end
    end
end

return PlayState:new()
