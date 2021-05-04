local Class = require 'lib.hump.Class'
local BaseState = require 'src.states.BaseState'

--#region
---@class TitleScreenState
local TitleScreenState = Class {__includes = BaseState}

function TitleScreenState:init()
end

function TitleScreenState:enter()
end

function TitleScreenState:exit()
end

function TitleScreenState:update(dt)
end

function TitleScreenState:render()
end

return TitleScreenState
--#endregion
