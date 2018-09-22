local SceneDirector = require "controllers.SceneDirector"
local GameDirector = require "controllers.GameDirector"
local ScaleDimension = require "util.ScaleDimension"

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    scaleDimension = ScaleDimension:new()
    gameDirector = GameDirector:new()
    sceneDirector = SceneDirector:new()
end

function love.keypressed(key, scancode, isrepeat)
    sceneDirector:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    sceneDirector:keyreleased(key, scancode)
end

function love.mousemoved(x, y, dx, dy, istouch)
    sceneDirector:mousemoved(x, y, dx, dy, istouch)
end

function love.mousepressed(x, y, button)
    sceneDirector:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    sceneDirector:mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
    sceneDirector:wheelmoved(x, y)
end

function love.update(dt)
    sceneDirector:update(dt)
end

function love.draw()
    sceneDirector:draw()
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.resize(w, h)
    scaleDimension:screenResize(w, h)
    sceneDirector:resize(w, h)
end