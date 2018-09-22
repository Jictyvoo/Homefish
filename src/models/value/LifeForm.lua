local Class = require "models.Class"
local LifeForm = Class:extends("LifeForm")

function LifeForm:new(name, starve)
	local this = {
		name = name or "Generic LifeForm",
		starve = {have = starve or 15, total = starve or 15}
	}

	return setmetatable(this, LifeForm)
end

function LifeForm:getStarve()
	return self.starve
end

function LifeForm:changeStarve(amount)
	self.starve.have = self.starve.have + amount
end

return LifeForm
