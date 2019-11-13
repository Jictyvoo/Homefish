local MegalodonAi = {}

MegalodonAi.__index = MegalodonAi

function MegalodonAi:new(actor)
    assert(actor, "Is needed a actor to manipulate")
    local this = setmetatable({
        actor = actor,
        elapsedTime = 0
    }, MegalodonAi)

    return this
end

function MegalodonAi:update(dt)
    
end

return MegalodonAi
