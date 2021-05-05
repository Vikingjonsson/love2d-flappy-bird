local Signal = require 'lib.hump.signal'
local bitser = require 'lib.bitser.bitser'
local log = require 'src.log'

local function copy_table(src)
  local t ={}
  for key, value in pairs(src) do
    t[key] = value
  end

  return t
end

local DEFAULT_STATE = {
  score = 0
}

local M={}
M.state = copy_table(DEFAULT_STATE)

---@param key string
---@param fallback ?string|number|table
---@return string|number|table|nil result
function M.get_value(key, fallback)
  local value = M.state[key]
  if value then
    return value
  end

  return fallback or nil
end

Signal.register(
  'reset',
  function()
    bitser.dumpLoveFile('save_point.dat', M.state)
    M.state = copy_table(DEFAULT_STATE)
  end
)

Signal.register(
  'score',
  function(value)
    M.score = M.score + value
  end
)

local value = bitser.loadLoveFile('save_point.dat')
log.dump(value)

return M
