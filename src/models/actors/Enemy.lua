local Fish = {}

Fish.__index = Fish

function Fish:new(spriteAnimation, world)
    
    local this = {
        move = false,
        speed = 250,
        elapsedTime = 0,
        orientation = "right",
        direction = "right",
        animation = "moving",
        movingKeys = {up = "up", down = "down", left = "left", right = "right"},
        world = world or love.physics.newWorld(0, 0),
        spriteAnimation = spriteAnimation or nil
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 10, 700, "dynamic")
    this.body:setFixedRotation(true)
    this.shape = love.physics.newRectangleShape(58, 54)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.fixture:setUserData("Fish")
    this.fixture:setMask(2)
    this.fixture:setCategory(1)
    
    return setmetatable(this, Fish)
end

function Fish:move(key)
    if self.movingKeys[key] and not self.hidden then
        self.direction = key;
        self.move = true
        self.orientation = self.movingKeys[key] == "left" and "left" or self.movingKeys[key] == "right" and "right" or self.orientation
    end
end

function Fish:getPosition()
    return self.body:getX(), self.body:getY()
end

function Fish:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function Fish:stopMoving()
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function Fish:reset()
    self.move = false
    self.body:setLinearVelocity(0, 0)
    self.body:setX(10); self.body:setY(700)
    self.orientation = "right"
    self.direction = "right"
    self.animation = "moving"
end

function Fish:beVulnerable()
    self.fixture:setCategory(1)
end

function Fish:getOrientation()
    return self.orientation
end

function Fish:compareFixture(fixture)
    return self.fixture == fixture
end

function Fish:retreat()
    self.invulnerable.time = 0
    self.invulnerable.active = true
    self.fixture:setCategory(2)
end

function Fish:update(dt)
    if self.spriteAnimation then
        self.spriteAnimation[self.animation]:update(dt)
    end
    if self.move then
        local xBodyVelocity, yBodyVelocity = 0, 0
        if self.direction == "left" or self.direction == "right" then
            xBodyVelocity = (self.direction == "left" and -1 or 1) * self.speed
        else
            yBodyVelocity = (self.direction == "down" and 1 or -1) * self.speed
        end
        self.body:setLinearVelocity(xBodyVelocity, yBodyVelocity)
    end
end

function Fish:draw()
    if self.spriteAnimation then
        local positionToDraw = self.animation
        local scaleX = self.orientation == "right" and 1 or -1
        self.spriteAnimation[positionToDraw]:draw(self.body:getX(), self.body:getY(), scaleX)
        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
end

return Fish
