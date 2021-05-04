local Class = require 'lib.hump.Class'
local BaseState = require 'src.states.BaseState'

local push = require 'lib.push.push'
local constants = require 'src.constants'
local Bird = require 'src.Bird'
local PipePair = require 'src.PipePair'
local keyboard = require 'src.keyboard'

--#region
---@class CountDownState
local CountDownState = Class {__includes = BaseState}

---CountDownState state constructor
function CountDownState:init()
end

function CountDownState:enter()
end

function CountDownState:exit()
end

function CountDownState:update(dt)
end

function CountDownState:render()
end

return CountDownState
--#endregion
