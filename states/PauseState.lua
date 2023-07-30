
PauseState = Class{__includes = BaseState}

local pauseSound = love.audio.newSource('pause.wav', 'static')

function PauseState.enter()
  MUSIC:pause()
  pauseSound:play()
end

function PauseState.exit()
  MUSIC:play()
end

function PauseState:update(dt)
  if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('pause') then
      gStateMachine:change('play')
  end
end


function PauseState:render()
  love.graphics.setFont(hugeFont)
  love.graphics.printf('PAUSED', 0, 120, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(smallFont)
  love.graphics.printf('Press P or Pause again to unpause.', 0, 180, VIRTUAL_WIDTH, 'center')
end
