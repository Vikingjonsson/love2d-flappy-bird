local Class = require 'lib.hump.class'
local constants = require 'src.constants'

local PIPE_HEIGHT = 60

--#region
---@class Pipe
local Pipe = Class {}

---Pipe constructor
---@param orientation string top or bottom positioned pipe
---@param y number y position
function Pipe:init(orientation, y)
  self.sprite = love.graphics.newImage('assets/sprites/pipe.png')
  self.width = self.sprite:getWidth() ---@type number
  self.height = self.sprite:getHeight() ---@type number
  self.orientation = orientation
  self.y = y
end

---Draw Pipe
---@param x number
function Pipe:draw(x)
  love.graphics.draw(
    self.sprite,
    x,
    self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y,
    0,
    1,
    self.orientation == 'top' and -1 or 1
  )
end

return Pipe
--#endregion
