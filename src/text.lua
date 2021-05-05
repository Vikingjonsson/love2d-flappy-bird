local M = {}

local FONTS = {
  small = love.graphics.newFont('assets/fonts/font.ttf', 8),
  medium = love.graphics.newFont('assets/fonts/flappy.ttf', 14),
  large = love.graphics.newFont('assets/fonts/flappy.ttf', 28),
  huge = love.graphics.newFont('assets/fonts/font.ttf', 56)
}

---Prints text
---@param font_size string small | medium | large | huge
---@param text string text to print
---@param x number x-axis
---@param y number y-axis
---@param limit number max width
---@param align number text alignment
function M.printf(font_size, text, x, y, limit, align)
  local previous_font = love.graphics.getFont()
  love.graphics.setFont(FONTS[font_size])
  love.graphics.printf(text, x, y, limit, align)
  love.graphics.setFont(previous_font)
end

return M
