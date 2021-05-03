local Class = require 'lib.hump.class'
local Pipe = require 'src.Pipe'
local constants = require 'src.constants'

local GAP_SIZE = 50
local PIPE_HEIGHT = 50

--#region
---@class PipePair
local PipePair = Class {}

---PipePair constructor
function PipePair:init(y)
  self.x = constants.VIRTUAL_WIDTH
  self.y = y + GAP_SIZE / 2
  self.remove = false
  self.speed = 60

  local top_pipe = Pipe('top', self.y - PIPE_HEIGHT - (GAP_SIZE / 2)) ---@type Pipe
  local bottom_pipe = Pipe('bottom', self.y + PIPE_HEIGHT + (GAP_SIZE / 2)) ---@type Pipe
  self.width = bottom_pipe.width

  ---@type Pipe[]
  self.pipes = {
    top = top_pipe,
    bottom = bottom_pipe
  }
end

---Update PipePair
---@param dt number
function PipePair:update(dt)
  self.x = self.x - self.speed * dt
end

---Draw PipePair
function PipePair:draw()
  self.pipes.top:draw(self.x)
  self.pipes.bottom:draw(self.x)
end

return PipePair
--#endregion
