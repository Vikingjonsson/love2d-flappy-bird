local M = {}
local SOUND_PATH = 'assets/sounds/'

M.SOUNDS = {
  explosion = love.audio.newSource(SOUND_PATH .. 'explosion.wav', 'static'),
  hurt = love.audio.newSource(SOUND_PATH .. 'hurt.wav', 'static'),
  score = love.audio.newSource(SOUND_PATH .. 'score.wav', 'static'),
  jump = love.audio.newSource(SOUND_PATH .. 'jump.wav', 'static'),
  music = love.audio.newSource(SOUND_PATH .. 'music.mp3', 'stream')
}

---Play sound
---@param sound_name string
---@param allow_overlap ?boolean allow same sound to overlap
---@param loop ?boolean [optional] loop sound defaults to false
function M.play_sound(sound_name, allow_overlap, loop)
  if loop then
    M.SOUND[sound_name]:setLooping(true)
  end

  if not M.SOUNDS[sound_name]:isPlaying() and not allow_overlap and not IS_MUTED then
    love.audio.play(M.SOUNDS[sound_name])
  end

  if allow_overlap and not IS_MUTED then
    love.audio.play(M.SOUNDS[sound_name])
  end
end

return M
