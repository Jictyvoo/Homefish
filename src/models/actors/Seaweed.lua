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
    this.fixture:setCategory(3)
    this.fixture:setMask(1, 2, 4)
    return setmetatable(this, Seaweed)
end

function Seaweed:compareFixture(fixture)
    return self.fixture == fixture
end

function Seaweed:getPosition()
    return self.body:getX(), self.body:getY()
end

function Seaweed:update(dt)
    self.animation:update(dt)
end

function Seaweed:draw()
    self.animation:draw(self.body:getX(), self.body:getY(), 0.125, 0.125)
    --love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end

return Seaweed
