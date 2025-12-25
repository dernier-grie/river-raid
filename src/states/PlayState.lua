PlayState = States.Base:new()

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
            Flier:new(40, 30, "plane")
        },
        ["floaters"] = {
            Floater:new(40, 60, "boat")
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

    if self.player.dx ~= 0 then
        local width = self.player:getWidth()
        local shouldCrash = self.terrain:intersects({
            x = self.player.x - width / 2,
            y = self.player.y,
            width = width,
            height = self.player.height,
        })
        if shouldCrash then
            GStateStack:push(States.Base:new()) -- actual gameover
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
            if bullet:collides(flier) then
                table.remove(self.fliers, kf)
                table.remove(self.bullets, kb)
            end
        end
    end

    for kf, floater in pairs(self.floaters) do
        floater:update(dt)

        for kb, bullet in pairs(self.bullets) do
            if bullet:collides(floater) then
                table.remove(self.floaters, kf)
                table.remove(self.bullets, kb)
            end
        end
    end

    for _, pickup in pairs(self.pickups) do
        pickup:update(dt)
    end

    for k = #self.explosions, 1, -1 do
        self.explosions[k]:update(dt)
        if self.explosions[k].outOfTime then
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
        GStateStack:push(States.Base:new()) -- actual gameover
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

return PlayState:new()
