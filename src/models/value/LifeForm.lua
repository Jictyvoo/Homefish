local Class = require "models.Class"
local LifeForm = Class:extends("LifeForm")

function LifeForm:new(name, starve)
	local this = {
		name = name or "Generic LifeForm",
		starve = {have = starve or 15, total = starve or 15}
	}

	return this
end

function LifeForm:getdanger()
	return self.danger
end

return LifeForm
