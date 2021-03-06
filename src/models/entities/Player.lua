local Player = {}; Player.__index = Player

function Player:new(spriteAnimation, world)
    
    local this = {
        scale = 0.125,
        x = 0, y = 0, move = false, hidden = false,
        invulnerable = {time = 20, toggle = false, limit = 20},
        speed = 250, elapsedTime = 0,
        orientation = "right", direction = "right", animation = "moving",
        movingKeys = {up = "up", down = "down", left = "left", right = "right"},
        world = world or love.physics.newWorld(0, 0),
        spriteAnimation = spriteAnimation or nil,
        sound = love.audio.newSource("assets/sfx/fishSwimming.wav", "static"),
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 10, 700, "dynamic")
    this.body:setFixedRotation(true)
    this.shape = love.physics.newRectangleShape(58, 30)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.fixture:setUserData("Player")
    this.fixture:setMask(2)
    this.fixture:setCategory(1)
    
    return setmetatable(this, Player)
end

function Player:keypressed(key, scancode, isrepeat)
    if self.movingKeys[key] and not self.hidden then
        self.direction = key; self.move = true
        self.orientation = self.movingKeys[key] == "left" and "left" or self.movingKeys[key] == "right" and "right" or self.orientation
    end

    if key == "space" then
        if not self.hidden then
            self.fixture:setCategory(3) -- category to colide with scenary
        else
            self.fixture:setCategory(1)
            self.x, self.y = 0, 0
            self.hidden = false
        end
        self.elapsedTime = 0
    end
end

function Player:keyreleased(key, scancode)
    if self.movingKeys[key] then
        if key == self.direction then
            self.move = false
            self.body:setLinearVelocity(0, 0)
        end
    end
end

function Player:getPosition() return self.body:getX(), self.body:getY() end

function Player:setPosition(x, y)
    assert(x and y, "X and Y must be a value")
    self.body:setLinearVelocity(0, 0)
    self.body:setSleepingAllowed(false)
    self.x, self.y = x, y
end

function Player:stopMoving()
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function Player:hide(x, y)
    self.hidden = true; self.fixture:setCategory(4); self:setPosition(x, y)
end

function Player:reset()
    self.move = false; self.hidden = false; self.body:setLinearVelocity(0, 0)
    self.body:setX(10); self.body:setY(700)
    self.orientation = "right"; self.direction = "right"; self.animation = "moving"
    self.invulnerable.time = 20; self.invulnerable.active = false
end

function Player:beVulnerable() self.fixture:setCategory(1) end

function Player:getOrientation() return self.orientation end

function Player:compareFixture(fixture) return self.fixture == fixture end

function Player:retreat()
    self.invulnerable.time = 0
    self.invulnerable.active = true
    self.fixture:setCategory(2)
end

function Player:update(dt)
    if self.fixture:getCategory() == 3 then
        self.elapsedTime = self.elapsedTime + dt
        if self.elapsedTime >= 0.5 then
            self.fixture:setCategory(1)
        end
    end
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
        if self.direction == "left" or self.direction == "right" then
            xBodyVelocity = (self.direction == "left" and -1 or 1) * self.speed
        else
            yBodyVelocity = (self.direction == "down" and 1 or -1) * self.speed
        end
        self.body:setLinearVelocity(xBodyVelocity, yBodyVelocity)
    end
end

function Player:draw()
    if self.spriteAnimation then
        local positionToDraw = self.animation
        local scaleX = self.orientation == "right" and 1 or -1
        local x = self.x ~= 0 and self.x or self.body:getX()
        local y = self.y ~= 0 and self.y or self.body:getY()
        self.spriteAnimation[positionToDraw]:draw(x, y, scaleX * self.scale, self.scale)
        --love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
end

return Player
