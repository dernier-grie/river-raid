Timer = {}

local easings = {
    ["linear"] = function(t)
        return t
    end,
    ["inOutSine"] = function(t)
        return -(math.cos(math.pi * t) - 1) / 2
    end,
}

function Timer:new()
    local this = {
        ["delays"] = {},
        ["intervals"] = {},
        ["tweens"] = {}
    }

    self.__index = self
    setmetatable(this, self)
    return this
end

function Timer:after(duration, callback, label)
    local delay = {
        ["timer"] = 0,
        ["duration"] = duration,
        ["callback"] = callback,
        ["label"] = label
    }

    table.insert(self.delays, delay)
end

function Timer:every(duration, callback, isImmediate, label)
    local interval = {
        ["timer"] = isImmediate and duration or 0,
        ["duration"] = duration,
        ["callback"] = callback,
        ["label"] = label
    }

    table.insert(self.intervals, interval)
end

function Timer:tween(duration, def, callback, label, easing)
    local interpolate = easing and easings[easing] or easings["linear"]
    local tween = {
        ["timer"] = 0,
        ["duration"] = duration,
        ["def"] = {},
        ["callback"] = callback,
        ["label"] = label,
        ["interpolate"] = interpolate
    }

    for ref, keyValuePairs in pairs(def) do
        local definition = {
            ["ref"] = ref,
            ["keyValuePairs"] = {}
        }
        for key, value in pairs(keyValuePairs) do
            local keyValuePair = {
                ["key"] = key,
                ["start"] = ref[key],
                ["finish"] = value,
            }
            table.insert(definition.keyValuePairs, keyValuePair)
        end

        table.insert(tween.def, definition)
    end

    table.insert(self.tweens, tween)
end

function Timer:update(dt)
    for k, delay in pairs(self.delays) do
        delay.timer = delay.timer + dt
        if delay.timer >= delay.duration then
            delay.callback()
            table.remove(self.delays, k)
        end
    end

    for _, interval in pairs(self.intervals) do
        interval.timer = interval.timer + dt
        if interval.timer >= interval.duration then
            interval.callback()
            interval.timer = interval.timer % interval.duration
        end
    end

    for k, tween in pairs(self.tweens) do
        tween.timer = tween.timer + dt
        local interpolate = tween.interpolate
        local t = tween.timer / tween.duration
        for _, definition in pairs(tween.def) do
            for _, keyValuePair in pairs(definition.keyValuePairs) do
                definition.ref[keyValuePair.key] = keyValuePair.start +
                    (keyValuePair.finish - keyValuePair.start) * interpolate(t)
            end
        end

        if tween.timer >= tween.duration then
            for _, definition in pairs(tween.def) do
                for _, keyValuePair in pairs(definition.keyValuePairs) do
                    definition.ref[keyValuePair.key] = keyValuePair.finish
                end
            end

            if tween.callback then
                tween.callback()
            end

            table.remove(self.tweens, k)
        end
    end
end

function Timer:remove(label)
    for k, delay in pairs(self.delays) do
        if delay.label == label then
            return table.remove(self.delays, k)
        end
    end

    for k, interval in pairs(self.intervals) do
        if interval.label == label then
            return table.remove(self.intervals, k)
        end
    end

    for k, tween in pairs(self.tweens) do
        if tween.label == label then
            return table.remove(self.tweens, k)
        end
    end
end

function Timer:reset()
    self.delays = {}
    self.intervals = {}
    self.tweens = {}
end

return Timer:new()
