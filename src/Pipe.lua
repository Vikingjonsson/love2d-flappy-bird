local Class = require 'lib.hump.class'
local constants = require 'src.constants'
local debug = require 'src.debug'

local PIPE_HEIGHT = 60

--#region
---@class Pipe
local Pipe = Class {}

---Pipe constructor
---@param orientation string top or bottom positioned pipe
---@param y number y-axis position
---@param x number x-axis position
---@param speed number movement speed
function Pipe:init(orientation, y, x, speed)
  self.sprite = love.graphics.newImage('assets/sprites/pipe.png')
  self.orientation = orientation
  self.x = x
  self.y = self.orientation == 'top' and y + PIPE_HEIGHT or y
  self.width = self.sprite:getWidth() ---@type number
  self.height = self.sprite:getHeight() ---@type number
  self.speed = speed

  self.hit_box = {
    x = self.x,
    y = self.orientation == 'top' and self.y - self.height or self.y,
    width = self.width,
    height = self.height
  }
end

function Pipe:update(dt)
  self.x = self.x - self.speed * dt
  self.hit_box.x = self.x
end

---Draw Pipe
function Pipe:draw()
  love.graphics.draw(self.sprite, self.x, self.y, 0, 1, self.orientation == 'top' and -1 or 1)

  debug.draw_hit_box(self.hit_box)
end

return Pipe
--#endregion
