local M = {}
local SOUND_PATH = 'assets/sounds/'

M.SOUNDS = {
  explosion = love.audio.newSource(SOUND_PATH .. 'explosion.wav', 'static'),
  hurt = love.audio.newSource(SOUND_PATH .. 'hurt.wav', 'static'),
  score = love.audio.newSource(SOUND_PATH .. 'score.wav', 'static'),
  jump = love.audio.newSource(SOUND_PATH .. 'jump.wav', 'static'),
  music = love.audio.newSource(SOUND_PATH .. 'music.mp3', 'stream')
}

local VOLUMES = {
  master = 0.2,
  effect = 0.1,
  music = 0.75
}

---Play sound
---@param sound_name string
---@param allow_overlap ?boolean allow same sound to overlap
---@param loop ?boolean [optional] loop sound defaults to false
---@param volume ?number[optional] sets sound volume, default to 0.5, 1-100
function M.play_sound(sound_name, allow_overlap, loop, volume)
  if not M.SOUNDS[sound_name] then
   return
  end

  if loop then
    M.SOUNDS[sound_name]:setLooping(true)
  end

  if not M.SOUNDS[sound_name]:isPlaying() and not allow_overlap and not IS_MUTED then
    love.audio.play(M.SOUNDS[sound_name])
  end

  if allow_overlap and not IS_MUTED then
    love.audio.play(M.SOUNDS[sound_name])
  end

  M.SOUNDS[sound_name]:setVolume(volume and volume/100 * VOLUMES.master or VOLUMES.master)
end

return M
