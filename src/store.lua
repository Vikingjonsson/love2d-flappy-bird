local Signal = require 'lib.hump.signal'
local M = {}

M.score = 0

---@param key string
---@param fallback ?string|number|table
---@return string|number|table|nil result
function M.get_value(key, fallback)
  local value = M[key]
  if value then
    return value
  end

  return fallback or nil
end

Signal.register(
  'score',
  function(value)
    print('triggered')
    M.score = M.score + value
  end
)

return M
