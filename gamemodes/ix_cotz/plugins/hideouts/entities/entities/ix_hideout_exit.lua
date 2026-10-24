AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Leave Hideout"
ENT.Spawnable = false
ENT.bNoPersist = true

local USE_DISTANCE_SQUARED = 128 * 128

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
		local PLUGIN = ix.plugin.Get("hideouts")
		if
			not IsValid(client)
			or not client:IsPlayer()
			or PLUGIN.members[client] ~= self.ixHideout
			or client:GetPos():DistToSqr(self:GetPos()) > USE_DISTANCE_SQUARED
		then
			return
		end
		local ok, err = PLUGIN:LeaveHideout(client, true)
		if not ok then
			client:Notify(err)
		end
	end
end
