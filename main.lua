local log = require 'src.log'
local push = require 'lib.push.push'
local Signal = require 'lib.hump.signal'
local Timer = require 'lib.hump.timer'
local constants = require 'src.constants'
local keyboard = require 'src.keyboard'
local StateMachine = require 'src.StateMachine'
local PlayState = require 'src.states.PlayState'
local CountDownState = require 'src.states.CountDownState'
local ScoreScreenState = require 'src.states.ScoreScreenState'
local TitleScreenState = require 'src.states.TitleScreenState'
local sound = require 'src.sound'

local is_debugger_active = os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1'

if is_debugger_active then
  IS_DEBUGGING = true
  require('lldebugger').start()
end

local function set_debugging_from_args(args)
  for _, value in ipairs(args) do
    if value == 'debug' then
      IS_DEBUGGING = true
    end
  end

  log.set_active(IS_DEBUGGING)
end

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

---@type StateMachine
local game_state =
  StateMachine(
  {
    title = function()
      return TitleScreenState()
    end,
    countdown = function()
      return CountDownState()
    end,
    play = function()
      return PlayState()
    end,
    score = function()
      return ScoreScreenState()
    end
  }
)

Signal.register(
  'player_is_dead',
  function()
    game_state:change('score')
  end
)

Signal.register(
  'start_game',
  function()
    game_state:change('play')
  end
)

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key)
  keyboard.add_pressed_keys(key)

  if key == 'escape' then
    love.event.quit(1)
  end

  if key == 'p' and not IS_PAUSED then
    IS_PAUSED = game_state:get_current_state() == 'play' and true or false
  elseif key == 'p' and IS_PAUSED then
    IS_PAUSED = false
  end
end



function love.load(args)
  set_debugging_from_args(args)

  math.randomseed(os.time())
  love.window.setTitle('Flappy bird')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  sound.play_sound('music')

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

  game_state:change('title')
end

function love.update(dt)
  Timer.update(dt)

  if IS_PAUSED then
    return
  end

  background.x = (background.x - background.speed * dt) % background.looping_point
  game_state:update(dt)
  ground.x = (ground.x - ground.speed * dt) % ground.looping_point
  keyboard.reset_pressed_keys()
end

function love.draw()
  push:start()
  love.graphics.draw(background.sprite, background.x, background.y)
  game_state:render()
  love.graphics.draw(ground.sprite, ground.x, ground.y)
  push:finish()
end
