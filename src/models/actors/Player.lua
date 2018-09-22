local Player = {}

Player.__index = Player

function Player:new(spriteAnimation, world)
    
    local this = {
        move = false,
        invulnerable = {time = 20, toggle = false, limit = 20},
        speed = 250,
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
    this.fixture:setUserData("Player")
    this.fixture:setMask(2)
    this.fixture:setCategory(1)
    
    return setmetatable(this, Player)
end

function Player:keypressed(key, scancode, isrepeat)
    if self.movingKeys[key] then
        self.direction = key;
        self.move = true
        self.orientation = self.movingKeys[key] == "left" and "left" or self.movingKeys[key] == "right" and "right" or self.orientation
    end

    if key == "space" then
        self.fixture.setCategory(3) -- category to colide with scenary
    end
end

function Player:keyreleased(key, scancode)
    if self.movingKeys[key] then
        if key == self.direction then
            self.move = false
        end
    end
end

function Player:getPosition()
    return self.body:getX(), self.body:getY()
end

function Player:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function Player:stopMoving()
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function Player:reset()
    self.move = false
    self.body:setLinearVelocity(0, 0)
    self.body:setX(10); self.body:setY(700)
    self.orientation = "right"
    self.animation = "moving"
    self.invulnerable.time = 20
end

function Player:getOrientation()
    return self.orientation
end

function Player:compareFixture(fixture)
    return self.fixture == fixture
end

function Player:retreat()
    self.invulnerable.time = 0
    self.invulnerable.active = true
    self.fixture:setCategory(2)
end

function Player:update(dt)
    if self.spriteAnimation then
        self.spriteAnimation[self.animation]:update(dt)
    end
    if self.invulnerable.active then
        if self.invulnerable.time < 20 then
            self.invulnerable.toggle = not self.invulnerable.toggle
            self.invulnerable.time = self.invulnerable.time + dt
        else
            self.invulnerable.active = false
            self.fixture:setCategory(1)
        end
    end
    if self.move then
        local xBodyVelocity, yBodyVelocity = 0, 0
        if self.orientation == "left" or self.orientation == "right" then
            xBodyVelocity = (self.orientation == "left" and 1 or -1) * self.speed
        else
            yBodyVelocity = (self.orientation == "down" and 1 or -1) * self.speed
        end
        self.body:setLinearVelocity(xBodyVelocity, yBodyVelocity)
    end
end

function Player:draw()
    if self.spriteAnimation then
        local positionToDraw = self.animation
        local scaleX = self.orientation == "right" and 1 or -1
        self.spriteAnimation[positionToDraw]:draw(self.body:getX(), self.body:getY(), scaleX)
        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
end

return Player
