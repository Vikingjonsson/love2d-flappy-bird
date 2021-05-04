local M = {}

---@param a table<string, number> representing a rectangle
---@param b table<string, number> representing a rectangle
---@return boolean result true if collision has happened otherwise false
function M.check_collision_AABB(a, b)
  local has_collision =
    a.x < b.x + b.width and a.y < b.y + b.height and b.x < a.x + a.width and b.y < a.y + a.height

  return has_collision
end

return M
