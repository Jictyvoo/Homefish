local World = {}

World.__index = World

local beginContact = function(a, b, coll)
    local playerFixture = a:getUserData() == "Player" and a or b:getUserData() == "Player" and b or nil
    local otherFixture = playerFixture == a and b or a
    if playerFixture then
        if otherFixture:getUserData() == "Scenary" then
            local x, y = gameDirector:getEntityByFixture(otherFixture):getPosition()
            gameDirector:getPlayer():hide(x, y)
        end
    end
end

local endContact = function(a, b, coll)
    
end

function World:new()
    world = love.physics.newWorld(0, 0)
    
    world:setCallbacks(beginContact, endContact)
    
    return setmetatable({world = world}, World)
end

function World:update(dt)
    self.world:update(dt)
end

return World
