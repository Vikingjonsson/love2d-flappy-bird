local Class = require 'lib.hump.class'
local Signal = require 'lib.hump.signal'
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

--#region
---@class PlayState
local PlayState = Class {__includes = BaseState}

---PlayState state constructor
function PlayState:init()
  self.bird = Bird() ---@type Bird
  self.pipePairs = {} ---@type PipePair[]
  self.score = 0
end

function PlayState:enter(...)
end

function PlayState:exit()
end

function PlayState:update(dt)
  self.bird:update(dt)

  spawn_timer = spawn_timer - dt
  if spawn_timer <= 0 then
    spawn_timer = DEFAULT_SPAWN_TIME
    table.insert(self.pipePairs, PipePair(last_y, SCROLL_SPEED))

    -- TODO: remove magic numbers
    local max_y = math.min(last_y + 20, constants.VIRTUAL_HEIGHT - 50)
    local min_y = math.max(50, last_y - 70)
    last_y = math.random(min_y, max_y)
  end

  for key, pair in pairs(self.pipePairs) do
    pair:update(dt)

    if
      self.bird:has_collision(pair.pipes.top.hit_box) or
        self.bird:has_collision(pair.pipes.bottom.hit_box)
     then
      self.bird.is_alive = false
      Signal.emit('player_died', self.bird.is_alive)
    end

    if pair.x < -pair.width then
      pair.remove = true
    end

    if pair.x < self.bird.x and self.bird.is_alive and not pair.is_scored then
      pair.is_scored = true
      self.score = self.score + 1
    end

    if pair.remove then
      table.remove(self.pipePairs, key)
    end
  end
end

function PlayState:render()
  for _, pair in pairs(self.pipePairs) do
    pair:draw()
  end

  self.bird:draw()
end

return PlayState
--#endregion
