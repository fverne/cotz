AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Squad Vendor"
ENT.Spawnable = false
ENT.bNoPersist = true

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end

	function ENT:Use(client)
		if IsValid(client) and client:IsPlayer() and client:GetCharacter() then
			ix.plugin.Get("hideouts"):OpenShop(client, self)
		end
	end
end
