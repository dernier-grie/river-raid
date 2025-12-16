PlayState = BaseState:new()

function PlayState:new()
    local player = Player:new(WIDTH / 2, HEIGHT - PLANE_HEIGHT)
    local terrain = Terrain:new()
    local ui = UI:new()

    local this = {
        ["player"] = player,
        ["terrain"] = terrain,
        ["ui"] = ui,
    }

    self.__index = self
    setmetatable(this, self)

    return this
end

function PlayState:update(dt)
    self.player:update(dt)
    if self.player.dx ~= 0 then
        local width = self.player.width -
            (self.player["banking"]) * math.abs(self.player["quads_index"] - self.player["quads_index_start"]) /
            self.player["quads_index_gap"]
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
end

function PlayState:draw()
    self.terrain:draw()
    self.ui:draw()
    self.player:draw()
end
