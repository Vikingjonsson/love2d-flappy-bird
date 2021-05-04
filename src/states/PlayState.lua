local Class = require 'lib.hump.Class'
local BaseState = require 'src.states.BaseState'

local push = require 'lib.push.push'
local constants = require 'src.constants'
local Bird = require 'src.Bird'
local PipePair = require 'src.PipePair'
local keyboard = require 'src.keyboard'

local DEFAULT_SPAWN_TIME = 2.5
local spawn_timer = DEFAULT_SPAWN_TIME
local SCROLL_SPEED = 60

-- TODO: remove magic numbers
local last_y =
  love.math.random(constants.VIRTUAL_HEIGHT / 2 - 70, constants.VIRTUAL_HEIGHT / 2 + 40)

local is_paused = false

--#region
---@class PlayState
local PlayState = Class {__includes = BaseState}

---PlayState state constructor
function PlayState:init()
  self.bird = Bird() ---@type Bird
  self.pipePairs = {} ---@type PipePair[]
end

function PlayState:enter()
end

function PlayState:exit()
end

function PlayState:update(dt)
  self.bird:update(dt)

  if spawn_timer <= 0 then
    spawn_timer = DEFAULT_SPAWN_TIME
    table.insert(self.pipePairs, PipePair(last_y, SCROLL_SPEED))

    -- TODO: remove magic numbers
    local max_y = math.min(last_y + 20, constants.VIRTUAL_HEIGHT - 50)
    local min_y = math.max(50, last_y - 70)
    last_y = math.random(min_y, max_y)
  end

  for _, pipePair in ipairs(self.pipePairs) do
    pipePair:update(dt)
  end
end

function PlayState:render()
end

return PlayState
--#endregion
