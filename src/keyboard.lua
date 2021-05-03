------------
--- Handles pressed keys
---
--- @module simple
local M = {}
M.pressed_keys = {}

---Add pressed key
---@param key string
---@return boolean result
function M.was_key_pressed(key)
  return M.pressed_keys[key]
end

---Test if a key was pressed
---@param key string
function M.add_pressed_keys(key)
  M.pressed_keys[key] = true
end

---Reset pressed keys
function M.reset_pressed_keys()
  M.pressed_keys = {}
end

return M
