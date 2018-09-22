local PlayerController = {}

PlayerController.__index = PlayerController

function PlayerController:new()
    local this = {

    }

    return setmetatable(this, PlayerController)
end

return PlayerController
