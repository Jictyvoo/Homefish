local MainMenuScene = {}

MainMenuScene.__index = MainMenuScene

local addButton = function(this, buttonName, sceneName, buttonDimensions, originalSize, callback)
    local scaleButtonName = "menu" .. buttonName

    --buttonName, x, y, width, height, image, originalImage, animation, 70
    local button = this.buttonManager:addButton(buttonName, buttonDimensions[3], buttonDimensions[4], buttonDimensions[1], buttonDimensions[2], this.buttonsQuads, this.buttonsImage)
    button.callback = callback or function(this) sceneDirector:reset(sceneName); sceneDirector:switchScene(sceneName) end    
    this.buttonNames[scaleButtonName] = button
end

function MainMenuScene:new()
    local this = {
        background = love.graphics.newImage("assets/background.png"),
        logo = love.graphics.newImage("assets/menuLogo.png"),
        buttonManager = gameDirector:getLibrary("ButtonManager"):new(),
        buttonsImage = nil,
        buttonsQuads = nil,
        buttonNames = {}
    }

    local spriteSheet = gameDirector:getLibrary("Pixelurite").getSpritesheet():new("buttons", "assets/gui/")
    local spriteQuads = spriteSheet:getQuads()
    this.buttonsQuads = {
        normal = spriteQuads["normal"],
        hover = spriteQuads["hover"],
        pressed = spriteQuads["pressed"],
        disabled = spriteQuads["disabled"]
    }
    this.buttonsImage = spriteSheet:getAtlas()

    local x, y, width, height = this.buttonsQuads["normal"]:getViewport()
    local originalSize = {width = width, height = height}
    addButton(this, 'Start Game', "inGame", {240, 100, 350, 320}, originalSize)
    addButton(this, 'Credits', "credits", {240, 100, 350, 420}, originalSize)

    return setmetatable(this, MainMenuScene)
end

function MainMenuScene:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
    self.buttonManager:keypressed(key, scancode, isrepeat)
end

function MainMenuScene:keyreleased(key, scancode)
    self.buttonManager:keyreleased(key, scancode)
end

function MainMenuScene:mousemoved(x, y, dx, dy, istouch)
    self.buttonManager:mousemoved(x, y, dx, dy, istouch)
end

function MainMenuScene:mousepressed(x, y, button)
    self.buttonManager:mousepressed(x, y, button)
end

function MainMenuScene:mousereleased(x, y, button)
    self.buttonManager:mousereleased(x, y, button)
end

function MainMenuScene:wheelmoved(x, y)
end

function MainMenuScene:update(dt)
    self.buttonManager:update(dt)
end

function MainMenuScene:draw()
    love.graphics.draw(self.background, 20, 0, 0, 1.393728222996516, 1.363636363636364)
    love.graphics.draw(self.logo, 400, 300, 0, 1, 1)
    self.buttonManager:draw()
end

function MainMenuScene:resize(w, h)end

return MainMenuScene
