AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Hideout Entrance"
ENT.Spawnable = false
ENT.bNoPersist = true

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physics = self:GetPhysicsObject()
		if IsValid(physics) then
			physics:EnableMotion(false)
		end
	end

	function ENT:Use(client)
		if IsValid(client) and client:IsPlayer() and client:GetCharacter() then
			ix.plugin.Get("hideouts"):ShowEntrance(client, self.ixEntranceID)
		end
	end
end
