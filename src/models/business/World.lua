local World = {}

World.__index = World

local beginContact = function(a, b, coll)
    
end

local endContact = function(a, b, coll)
    
end

function World:new()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0)
    
    world:setCallbacks(beginContact, endContact)
    
    return setmetatable({world = world}, World)
end

function World:update(dt)
    self.world:update(dt)
end

return World
