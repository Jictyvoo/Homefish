local Seaweed = {}

Seaweed.__index = Seaweed

function Seaweed:new(animation, world, x, y)
    assert(world, "Seaweed needs a world object")
    assert(animation, "Seaweed needs a animation object")
    local this = {
        animation = animation,
        body = love.physics.newBody(world , x, y, "static"),
        shape = love.physics.newRectangleShape(64, 64),
        fixture = nil
    }
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.fixture:setUserData("Scenary")
    return setmetatable(this)
end

function Seaweed:update(dt)
    self.animation:update(dt)
end

function Seaweed:draw()
    self.animation:draw()
end

return Seaweed
