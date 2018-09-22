local PlayerController = {}

PlayerController.__index = PlayerController

function PlayerController:new(lifeForm)
    assert(lifeForm, "Needs a LifeForm!")
    print(lifeForm.getStarve)
    local this = {
        lifeForm = lifeForm,
        elapsedTime = 0
    }

    return setmetatable(this, PlayerController)
end

function PlayerController:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime >= 6 then
        self.lifeForm:changeStarve(-2)
        self.elapsedTime = 0
        gameDirector:updateStarveBar(2, true)
    end
end

return PlayerController
