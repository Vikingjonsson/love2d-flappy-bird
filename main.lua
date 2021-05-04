if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
  require('lldebugger').start()
end

_G.debugging = false

local push = require 'lib.push.push'
local constants = require 'src.constants'
local Bird = require 'src.Bird'
local PipePair = require 'src.PipePair'
local keyboard = require 'src.keyboard'

local background = {
  sprite = love.graphics.newImage('assets/sprites/background.png'),
  looping_point = -413,
  speed = 30,
  x = 0,
  y = 0
}

local ground = {
  sprite = love.graphics.newImage('assets/sprites/ground.png'),
  speed = 60,
  height = 16,
  looping_point = -constants.VIRTUAL_WIDTH,
  x = 0,
  y = constants.VIRTUAL_HEIGHT - 16
}

local spawn_timer = 2
local player = Bird() ---@type Bird
local pipePairs = {} ---@type PipePair[]
local last_y =
  love.math.random(constants.VIRTUAL_HEIGHT / 2 - 70, constants.VIRTUAL_HEIGHT / 2 + 40)

local is_paused = false

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  keyboard.add_pressed_keys(key)
  if key == 'escape' then
    love.event.quit(1)
  end

  if key == 'p' and not is_paused then
    is_paused = true
  elseif key == 'p' and is_paused then
    is_paused = false
  end
end

function love.load()
  math.randomseed(os.time())

  love.window.setTitle('Flappy bird')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  push:setupScreen(
    constants.VIRTUAL_WIDTH,
    constants.VIRTUAL_HEIGHT,
    constants.WINDOW_WIDTH,
    constants.WINDOW_HEIGHT,
    {
      fullscreen = false,
      resizable = true,
      highdpi = true,
      vsync = true
    }
  )
end

function love.update(dt)
  if is_paused then
    return
  end

  background.x = (background.x - background.speed * dt) % background.looping_point
  ground.x = (ground.x - ground.speed * dt) % ground.looping_point
  player:update(dt)

  spawn_timer = spawn_timer - dt
  if spawn_timer <= 0 then
    spawn_timer = 2.5
    table.insert(pipePairs, PipePair(last_y, ground.speed))

    -- TODO: remove magic numbers
    local max_y = math.min(last_y + 20, constants.VIRTUAL_HEIGHT - 50)
    local min_y = math.max(50, last_y - 70)
    last_y = math.random(min_y, max_y)
  end

  for index, pair in ipairs(pipePairs) do
    pair:update(dt)
    local top, bottom = pair.pipes.top.hit_box, pair.pipes.bottom.hit_box

    if player:has_collision(top) or player:has_collision(bottom) then
      is_paused = true
    end

    if pair.x < -pair.width then
      pair.remove = true
    end
  end

  for i = #pipePairs, 1, -1 do
    if pipePairs[i].remove then
      local pair = pipePairs[i]
      table.remove(pipePairs, 0)
      table.remove(pipePairs, 0)
      table.remove(pipePairs, i)
    end
  end

  keyboard.reset_pressed_keys()
end

function love.draw()
  push:start()
  love.graphics.draw(background.sprite, background.x, background.y)
  for _, pair in pairs(pipePairs) do
    pair:draw()
  end

  love.graphics.draw(ground.sprite, ground.x, ground.y)
  player:draw()
  push:finish()
end
