local MegalodonAi = {}

MegalodonAi.__index = MegalodonAi

function MegalodonAi:new(actor)
    assert(actor, "Is needed a actor to manipulate")
    local this = {
        actor = actor,
        elapsedTime = 0
    }

    return setmetatable(this, MegalodonAi)
end

function MegalodonAi:update(dt)
    
end

return MegalodonAi
