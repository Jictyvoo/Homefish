--Models
local World = require "models.business.World"
local GameState = require "models.business.GameState"

--Actors
local Player = require "models.actors.Player"

--Util
local SpriteSheet = require "util.SpriteSheet"
local SpriteAnimation = require "util.SpriteAnimation"
local Stack = require "util.Stack"
local TilemapLoader = require "util.TilemapLoader"

--Controllers
local CameraController = require "controllers.CameraController"
local EntityController = require "controllers.EntityController"
local PlayerController = require "controllers.PlayerController"

--Gui Components
local ButtonManager = require "util/ui/ButtonManager"
local ProgressBar = require "util.ui.ProgressBar"

local GameDirector = {}

GameDirector.__index = GameDirector

function GameDirector:configureSpriteSheet(jsonFile, directory, looping, duration, scaleX, scaleY, centerOrigin)
    local newSprite = SpriteSheet:new(jsonFile, directory)
    local frameTable, frameStack = newSprite:getFrames()
    local newAnimation = SpriteAnimation:new(frameTable, newSprite:getAtlas(), duration)
    if centerOrigin then
        newAnimation:setOrigin(newSprite:getCenterOrigin())
    end
    newAnimation:setType(looping)
    newAnimation:setScale(scaleX, scaleY)
    return newAnimation
end

function GameDirector:new()
    
    local playerAnimation = {
        moving = GameDirector:configureSpriteSheet("Player_Move.json", "assets/sprites/player/", true, 0.1, 1, 1, true),
    }
    local LifeForm = require "models.value.LifeForm"
    local world = World:new()
    local this = {
        elapsedTime = 0,
        world = world,
        player = Player:new(playerAnimation, world.world),
        dangerBar = ProgressBar:new(20, 20, 200, 40, {1, 0, 0}, 100, 0),
        starveBar = ProgressBar:new(20, 20, 200, 40, {0.45, 0.39, 0}, 100, 100),
        entityController = EntityController:new(),
        playerController = PlayerController:new(LifeForm:new("Player", 100)),
        cameraController = CameraController:new(),
        gameState = GameState:new(),
        --Libraries
        libraries = {
            SpriteSheet = SpriteSheet, TilemapLoader = TilemapLoader,
            SpriteAnimation = SpriteAnimation, Stack = Stack, LifeForm = LifeForm,
            ProgressBar = ProgressBar, GameState = GameState, ButtonManager = ButtonManager
        }
    }
    this.gameState:save(this.dangerBar, "dangerBar")
    return setmetatable(this, GameDirector)
end

function GameDirector:reset()
    self.entityController:generateEntities(self.world.world)
    self.dangerBar = self.gameState:load("dangerBar")
    self.player:reset()
end

function GameDirector:getLibrary(library)
    return self.libraries[library]
end

function GameDirector:keypressed(key, scancode, isrepeat)
    self.player:keypressed(key, scancode, isrepeat)
end

function GameDirector:keyreleased(key, scancode)
    self.player:keyreleased(key, scancode)
end

function GameDirector:updateDangerBar(amount, decrease)
    if decrease then
        self.dangerBar:decrement(amount)
    else
        self.dangerBar:increment(amount)
    end
end

function GameDirector:updateStarveBar(amount, decrease)
    if decrease then
        self.starveBar:decrement(amount)
    else
        self.starveBar:increment(amount)
    end
end

function GameDirector:getEntityByFixture(fixture)
    if fixture:getUserData() == "Player" then
        return self.player
    end
    return self.entityController:getEntityByFixture(fixture)
end

function GameDirector:getPlayer()
    return self.player, self.playerController
end

function GameDirector:getDangerBar()
    return self.dangerBar
end

function GameDirector:getStarveBar()
    return self.starveBar
end

function GameDirector:getCameraController()
    return self.cameraController
end

function GameDirector:getEntityController()
    return self.entityController
end

function GameDirector:getWorld()
    return self.world
end

function GameDirector:runGame()
    return self.elapsedTime > 0.01 and self.dangerBar:getValue() > 0
end

function GameDirector:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime > 0.01 then
        if self.starveBar:getValue() > 0 or self.dangerBar:getValue() < 100 then
            self.world:update(dt)
            self.player:update(dt)
            self.playerController:update(dt)

            self.cameraController:update(dt)
        else
            --here will call gameOver scene
            sceneDirector:previousScene()
        end
        self.elapsedTime = 0
    end
    if self.player:getPosition() >= 1200 then
        sceneDirector:switchSubscene("gameOver")
    end
end

function GameDirector:draw()
end

return GameDirector
