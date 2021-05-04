local Class = require 'lib.hump.Class'

--#region
---@class BaseState
local BaseState = Class {}

function BaseState:init()
end

function BaseState:enter()
end

function BaseState:exit()
end

function BaseState:update(dt)
end

function BaseState:render()
end

return BaseState
--#endregion
