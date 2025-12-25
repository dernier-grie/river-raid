require "src.globals"
Timer = require "src.lib.Timer"

UI = {
    Score    = require "src.ui.Score",
    LineBox  = require "src.ui.LineBox",
    RoughBox = require "src.ui.RoughBox"
}
UI.Console = require "src.ui.Console"


Actors = {
    Player    = require "src.actors.Player",
    Bullet    = require "src.actors.Bullet",
    Explosion = require "src.actors.Explosion",
    Pickup    = require "src.actors.Pickup",
    Flier     = require "src.actors.Flier",
    Floater   = require "src.actors.Floater"
}

World = {
    Terrain    = require "src.world.Terrain",
    Bridge     = require "src.world.Bridge",
    Islet      = require "src.world.Islet",
    Decoration = require "src.world.Decoration"
}

StateStack = require "src.states.StateStack"
States = {
    Base = require "src.states.BaseState",
}
States.Title = require "src.states.TitleState"
States.Play = require "src.states.PlayState"
