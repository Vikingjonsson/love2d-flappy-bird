local M = {}

---Draw a rectangle hit box
---@param hit_box table<string, number> x, y, width, height
function M.draw_hit_box(hit_box)
  if IS_DEBUGGING then
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('line', hit_box.x, hit_box.y, hit_box.width, hit_box.height)
    love.graphics.setColor(r, g, b, a)
  end
end

return M
