--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.bronzeMedalImage = love.graphics.newImage('bronze_medal.png')
    self.silverMedalImage = love.graphics.newImage('silver_medal.png')
    self.goldMedalImage = love.graphics.newImage('gold_medal.png')
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    local topMessage = ''
    local middleMessage = ''
    local medalImage = nil
    
    if self.score == 0 then
        topMessage = 'Oof! You lost :('
    elseif self.score < 10 then
        topMessage = 'Gratz! You won a bronze medal.'
        middleMessage = 'Think you can make 10 or more points next time?'
        medalImage = self.bronzeMedalImage
    elseif self.score < 20 then
        topMessage = 'Wow! You got a silver medal!'
        middleMessage = 'Do you think you can grab that gold one over 20 points?'
        medalImage = self.silverMedalImage
    else
        topMessage = "NICE! You're a true bird champion!"
        medalImage = self.goldMedalImage
    end
    
    love.graphics.setFont(flappyFont)
    love.graphics.printf(topMessage, 0, 60, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if medalImage then
        love.graphics.draw(medalImage, VIRTUAL_WIDTH / 2 - medalImage.getWidth(medalImage), 105, 0, 2, 2)
    end

    love.graphics.printf(middleMessage .. '\n\nPress Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')
end
