local Class = require 'lib.hump.class'
local constant = require 'src.constants'
local keyboard = require 'src.keyboard'

local GRAVITY = 40
local ANIT_GRAVITY = -8

--#region Bird
---@class Bird
local Bird = Class {}

---Bird constructor
function Bird:init()
  self.sprite = love.graphics.newImage('assets/sprites/bird.png')

  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()

  self.y = (constant.VIRTUAL_HEIGHT / 2) - (self.height / 2)
  self.x = (constant.VIRTUAL_WIDTH / 3) - (self.width / 2)
  self.dy, self.dx = 0, 0
end

---Update Bird
---@param dt number
function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy

  if keyboard.was_key_pressed('space') then
    self.dy = ANIT_GRAVITY
  end
end

---Draw bird
function Bird:draw()
  love.graphics.draw(self.sprite, self.x, self.y)
end

return Bird
--#endregion
