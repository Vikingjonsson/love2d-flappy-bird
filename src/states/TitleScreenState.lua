local Class = require 'lib.hump.class'
local Signal = require 'lib.hump.signal'
local BaseState = require 'src.states.BaseState'
local constants = require 'src.constants'
local keyboard = require 'src.keyboard'
local text = require 'src.text'

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
  if keyboard.was_key_pressed('space') then
    Signal.emit('start_game')
    Signal.emit('reset')
  end
end

function TitleScreenState:render()
  text.printf(
    'large',
    'Flappy Bird',
    0,
    constants.VIRTUAL_HEIGHT / 3,
    constants.VIRTUAL_WIDTH,
    'center'
  )

  if math.floor(love.timer.getTime()) % 2 == 0 then
    text.printf(
      'medium',
      'Press Space to Start!',
      0,
      constants.VIRTUAL_HEIGHT / 2,
      constants.VIRTUAL_WIDTH,
      'center'
    )
  end
end

return TitleScreenState
--#endregion
