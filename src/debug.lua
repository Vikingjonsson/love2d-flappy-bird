local M = {}

---Draw a rectangle hit box
---@param hit_box table<string, number> x, y, width, height
function M.draw_hit_box(hit_box)
  if IS_DEBUGGING then
    love.graphics.rectangle('line', hit_box.x, hit_box.y, hit_box.width, hit_box.height)
  end
end

return M
