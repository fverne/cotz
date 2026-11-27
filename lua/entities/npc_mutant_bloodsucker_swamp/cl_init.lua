include("shared.lua")

local CLOAK_MATERIAL = "models/shadertest/predator"
local REVEAL_DISTANCE_SQR = 150 ^ 2

function ENT:Draw()
	local cloaked = self:GetPos():DistToSqr(LocalPlayer():GetPos()) > REVEAL_DISTANCE_SQR
	-- Clearing the override restores the skin's own material. Compare with the live material, which the
	-- engine can reset when the entity is networked again.
	local material = cloaked and CLOAK_MATERIAL or ""
	if self:GetMaterial() ~= material then
		self:SetMaterial(material)
		self:DrawShadow(not cloaked)
	end

	self:DrawModel()
end
