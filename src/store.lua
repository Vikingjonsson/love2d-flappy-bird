local Signal = require 'lib.hump.signal'
local bitser = require 'lib.bitser.bitser'
local log = require 'src.log'

local function copy_table(src)
  local t = {}
  for key, value in pairs(src) do
    t[key] = value
  end

  return t
end

local SAVE_FILE = 'high_score.dat'

local DEFAULT_STATE = {
  score = 0,
  best_score = 0
}

local M = copy_table(DEFAULT_STATE)
-- bitser.dumpLoveFile(SAVE_FILE, 1)

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
  'load_score',
  function()
    if love.filesystem.getInfo(SAVE_FILE) then
      M.best_score = bitser.loadLoveFile(SAVE_FILE)
    else
      bitser.dumpLoveFile(SAVE_FILE, M.best_score)
    end
  end
)

Signal.register(
  'reset',
  function()
    M.score = 0
  end
)

Signal.register(
  'score',
  function(value)
    M.score = M.score + value
  end
)

Signal.register(
  'player_is_dead',
  function()
    if M.score > M.best_score then
      bitser.dumpLoveFile(SAVE_FILE, M.score)
    end
  end
)

return M
