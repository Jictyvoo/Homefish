local SplashScreen = {}; SplashScreen.__index = SplashScreen

local function rescaleImage(image)
    local imageDimension = {width = image:getWidth(), height = image:getHeight()}
    local item = {x = 0, y = 0, scaleX = 0, scaleY = 0, image = image}
    item.scaleX, item.scaleY = love.graphics.getWidth() / 800, love.graphics.getHeight() / 600
    local x, y = false, false
    if item.scaleX < item.scaleY then item.scaleY = item.scaleX
    else item.scaleX = item.scaleY
    end
    item.x = (love.graphics.getWidth() / 2) - imageDimension.width / 2
    item.y = (love.graphics.getHeight() / 2) - imageDimension.height / 2
    return item
end

function SplashScreen:new()
    local this = {
        splash_company = rescaleImage(love.graphics.newImage("assets/company_logo.png")),
        splash_loveLogo = rescaleImage(love.graphics.newImage("assets/engine_logo.png")),
        all = {"splash_company", "splash_loveLogo"},
        current = 1,
        elapsedTime = 0
    }
    
    return setmetatable(this, SplashScreen)
end

function SplashScreen:keypressed(key, scancode, isrepeat)
    self.elapsedTime = 3
end

function SplashScreen:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime > 2 then
        self.current = self.current + 1
        self.elapsedTime = 0
        if self.current > #self.all then
            sceneDirector:clearStack("mainMenu")
        end
    end
end

function SplashScreen:draw()
    local item = self.all[self.current]
    if item then
        love.graphics.draw(self[item].image, self[item].x, self[item].y, 0, self[item].scaleX, self[item].scaleY)
    end
end

return SplashScreen
