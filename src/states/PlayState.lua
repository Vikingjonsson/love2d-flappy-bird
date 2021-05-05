local Class = require 'lib.hump.class'
local Signal = require 'lib.hump.signal'
local BaseState = require 'src.states.BaseState'
local Bird = require 'src.Bird'
local PipePair = require 'src.PipePair'
local constants = require 'src.constants'
local store = require 'src.store'
local text = require 'src.text'

local SCROLL_SPEED = 60
local DEFAULT_SPAWN_TIME = 2.5
local spawn_timer = 0.5

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
end

function PlayState:enter(...)
  Signal.emit('reset')
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
      self.bird:set_is_alive(false)
    end

    if pair.x + pair.width < self.bird.x and self.bird.is_alive and not pair.is_scored then
      pair.is_scored = true
      Signal.emit('score', 1)
    end

    if pair.x < -pair.width then
      pair.remove = true
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

  text.printf(
    'medium',
    'Score: ' .. store.get_value('score'),
    12,
    12,
    constants.VIRTUAL_WIDTH,
    'left'
  )
end

return PlayState
--#endregion
