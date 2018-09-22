local InGameScene = {}

InGameScene.__index = InGameScene

function InGameScene:new(world)
    local this = {
        sound = love.audio.newSource("assets/sfx/FishHomeBackAudio.wav", "static"),
        background = love.graphics.newImage("assets/sprites/background.png"),
        controls = love.graphics.newImage("assets/sprites/controls.png")
    }
    this.sound:setLooping(true)
    return setmetatable(this, InGameScene)
end

function InGameScene:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        sceneDirector:switchSubscene("pause")
    end
    gameDirector:getPlayer():keypressed(key, scancode, isrepeat)
end

function InGameScene:keyreleased(key, scancode)
    gameDirector:getPlayer():keyreleased(key, scancode)
end

function InGameScene:reset()
    gameDirector:reset()
    self.sound:play()
end

function InGameScene:update(dt)
    gameDirector:update(dt)
end

function InGameScene:draw()
    love.graphics.draw(self.background)
    local player, characterController = gameDirector:getPlayer()
    gameDirector:getDangerBar():draw()
    gameDirector:getStarveBar():draw()
    gameDirector:getCameraController():draw(function()
        gameDirector:getEntityController():draw()
        love.graphics.draw(self.controls, 30, 500, 0, 0.125, 0.125)
        player:draw()
    end)
end

return InGameScene
