local Class = require 'lib.hump.class'
local Signal = require 'lib.hump.signal'
local BaseState = require 'src.states.BaseState'
local constants = require 'src.constants'
local store = require 'src.store'
local keyboard = require 'src.keyboard'
local text = require 'src.text'

--#region
---@class ScoreScreenState
local ScoreScreenState = Class {__includes = BaseState}

---ScoreScreenState state constructor
function ScoreScreenState:init()
end

function ScoreScreenState:enter()
  Signal.emit('load_score')
end

function ScoreScreenState:exit()
end

function ScoreScreenState:update(dt)
  if keyboard.was_key_pressed('r') then
    Signal.emit('start_game')
  end
end

function ScoreScreenState:render()
  text.printf(
    'large',
    'Score: ' .. store.get_value('score'),
    0,
    constants.VIRTUAL_HEIGHT / 4,
    constants.VIRTUAL_WIDTH,
    'center'
  )

  text.printf(
    'medium',
    'Best score: ' .. store.get_value('best_score'),
    0,
    constants.VIRTUAL_HEIGHT / 3 + 12,
    constants.VIRTUAL_WIDTH,
    'center'
  )

  if math.floor(love.timer.getTime()) % 2 == 0 then
    text.printf(
      'medium',
      'Press R to restart!',
      0,
      constants.VIRTUAL_HEIGHT / 2,
      constants.VIRTUAL_WIDTH,
      'center'
    )
  end
end

return ScoreScreenState
--#endregion
