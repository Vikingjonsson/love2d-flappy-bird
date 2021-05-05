local M = {}

local FONTS = {
  small = love.graphics.newFont('assets/fonts/font.ttf', 8),
  medium = love.graphics.newFont('assets/fonts/flappy.ttf', 14),
  large = love.graphics.newFont('assets/fonts/flappy.ttf', 28),
  huge = love.graphics.newFont('assets/fonts/font.ttf', 56)
}

function M.printf(font_size, text, x, y, limit, align)
  local previous_font = love.graphics.getFont()
  love.graphics.setFont(FONTS[font_size])
  love.graphics.printf(
    text,
    x,
    y,
    limit,
    align
    --,
    -- r(number),
    -- sx(number),
    -- sy(number),
    -- ox(number),
    -- oy(number),
    -- kx(number),
    -- ky(number)
  )
  love.graphics.setFont(previous_font)
end

return M
