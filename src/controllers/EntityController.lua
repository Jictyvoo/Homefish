local EntityController = {}

EntityController.__index = EntityController

function EntityController:new()
    local this = {
        entities = {}
    }

    return setmetatable(this, EntityController)
end

function EntityController:generateEntities()
    
end

function EntityController:getEntityByFixture(fixture)
    for _, entity in pairs(self.entities) do
        if entity.compareFixture(fixture) then
            return entity
        end
    end
    return nil
end

return EntityController
