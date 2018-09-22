local GameOver = {}

GameOver.__index = GameOver

function GameOver:new()
    local this = {

    }

    return setmetatable(this, GameOver)
end

function GameOver:keypressed(key, scancode, isrepeat)
end

return GameOver
