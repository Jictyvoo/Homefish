function love.load()
    --set default constants
    love.graphics.setDefaultFilter('nearest', 'nearest')
    StoneMoSScreen = require "libs.StoneMoSScreen"; StoneMoSScreen.new(true, 800, 600)
    gameDirector = require "controllers.GameDirector":new()
    love.graphics.setFont(gameDirector:getFonts().tovariSans)
    sceneDirector = gameDirector:getLibrary("MoonJohn").MoonJohn:new(require "scenes.SplashScreen":new())
    --Adding Scenes to SceneDirector
    local inGame = require "scenes.InGameScene":new(gameDirector:getWorld().world)
    sceneDirector:setDefaultTransition(function() return gameDirector:getLibrary("MoonJohn").Transitions:FadeOut() end)

    sceneDirector:addScene("mainMenu", require "scenes.MainMenuScene":new())
    sceneDirector:addScene("credits", require "scenes.CreditsScene":new())
    --[[sceneDirector:addScene("configurations", require "scenes.ConfigurationScene":new())--]]
    sceneDirector:addScene("inGame", inGame)
    --sceneDirector:clearStack("inGame")
    sceneDirector:addSubscene("pause", require "scenes.subscenes.PauseGame":new())
    sceneDirector:addSubscene("gameOver", require "scenes.subscenes.GameOver":new())

    local events = {"keypressed", "keyreleased", "mousemoved", "mousepressed", "mousereleased", "wheelmoved", "update", "draw"}
    for _, event in pairs(events) do
        love[event] = function(...) sceneDirector[event](sceneDirector, ...) end
    end
end

function love.resize(w, h)
    StoneMoSScreen:getScaleDimension():screenResize(w, h)
    sceneDirector:resize(w, h)
end
