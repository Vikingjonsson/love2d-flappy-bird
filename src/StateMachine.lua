local Class = require 'lib.hump.class'

--#region
---@class StateMachine
local StateMachine = Class {}

---StateMachine constructor
---@param states table<string, function> table containting game states and state functions
function StateMachine:init(states)
  self.empty = {
    ['enter'] = function(...)
    end,
    ['update'] = function(dt)
    end,
    ['render'] = function()
    end,
    ['exit'] = function(...)
    end
  }

  self.states = states or {}
  self.current = self.empty
  self.current_state_name = ''
end

---Returns the current currently active state
---@return string state name
function StateMachine:get_current_state()
  return self.current_state_name
end

function StateMachine:change(state_name, enter_params)
  assert(self.states[state_name])

  self.current:exit()
  self.current = self.states[state_name]()
  self.current_state_name = state_name
  self.current:enter(enter_params)
end

function StateMachine:update(dt)
  self.current:update(dt)
end

function StateMachine:render()
  self.current:render()
end

return StateMachine
--#endregion
