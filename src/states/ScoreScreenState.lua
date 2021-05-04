local Class = require 'lib.hump.Class'
local BaseState = require 'src.states.BaseState'

--#region
---@class ScoreScreenState
local ScoreScreenState = Class {__includes = BaseState}

---ScoreScreenState state constructor
function ScoreScreenState:init()
end

function ScoreScreenState:enter()
end

function ScoreScreenState:exit()
end

function ScoreScreenState:update(dt)
end

function ScoreScreenState:render()
end

return ScoreScreenState
--#endregion
