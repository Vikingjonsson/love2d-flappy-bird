local Class = require 'lib.hump.class'
local constant = require 'src.constants'
local keyboard = require 'src.keyboard'
local collission_detection = require 'src.collision'
local debug = require 'src.debug'

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

  self.hit_box = {x = self.x + 4, y = self.y + 4, width = self.width - 4, height = self.height - 4}
end

---Checks if Bird has collides
---@param collider table<string,number> table with x, y, width, height fields
---@return boolean result true if has collided else fasle
function Bird:has_collision(collider)
  return collission_detection.check_collision_AABB(self.hit_box, collider)
end

---Update Bird
---@param dt number
function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy
  self.hit_box = {x = self.x + 4, y = self.y + 4, width = self.width - 8, height = self.height - 8}

  if keyboard.was_key_pressed('space') then
    self.dy = ANIT_GRAVITY
  end
end

---Draw bird
function Bird:draw()
  love.graphics.draw(self.sprite, self.x, self.y)

  debug.draw_hit_box(self.hit_box)
end

return Bird
--#endregion
