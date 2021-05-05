local Class = require 'lib.hump.Class'
local BaseState = require 'src.states.BaseState'
local constants = require 'src.constants'
local store = require 'src.store'

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
  love.graphics.setFont(FONTS.large_font)
  love.graphics.printf(
    'Score: ' .. store.get_value('score'),
    0,
    constants.VIRTUAL_HEIGHT / 3,
    constants.VIRTUAL_WIDTH,
    'center'
  )

  if math.floor(love.timer.getTime()) % 2 == 0 then
    love.graphics.setFont(FONTS.medium_font)
    love.graphics.printf(
      'Press Space to Start!',
      0,
      constants.VIRTUAL_HEIGHT / 2,
      constants.VIRTUAL_WIDTH,
      'center'
    )
  end
end

return ScoreScreenState
--#endregion
